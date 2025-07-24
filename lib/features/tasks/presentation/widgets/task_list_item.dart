import 'package:flutter/material.dart';
import '../../../../core/models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Function(String) onStatusChanged;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final procedure = task.procedure;
    if (procedure == null) return const SizedBox.shrink();

    final isCompleted = task.status == 'completed';
    final priorityColor = _getPriorityColor(procedure.priority);

    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        onChanged: (value) {
          onStatusChanged(value! ? 'completed' : 'pending');
        },
      ),
      title: Text(
        procedure.name,
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
          color: isCompleted ? Colors.grey : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (procedure.defaultDeadline != null && procedure.defaultDeadline != 'なし')
            Text(
              '期限: ${procedure.defaultDeadline}',
              style: TextStyle(
                color: priorityColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (procedure.responsibleOffice != null)
            Text('窓口: ${procedure.responsibleOffice}'),
          if (task.notes != null && task.notes!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'メモ: ${task.notes}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
      trailing: Container(
        width: 8,
        height: 40,
        decoration: BoxDecoration(
          color: priorityColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onTap: () {
        _showTaskDetails(context, procedure);
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showTaskDetails(BuildContext context, dynamic procedure) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    procedure.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              _buildDetailSection('理由・説明', procedure.reason),
              
              if (procedure.hint != null)
                _buildDetailSection('ヒント', procedure.hint!),
              
              if (procedure.requiredDocuments.isNotEmpty)
                _buildDetailSection(
                  '必要書類',
                  procedure.requiredDocuments.join('\n'),
                ),
              
              if (procedure.defaultDeadline != null && procedure.defaultDeadline != 'なし')
                _buildDetailSection('期限', procedure.defaultDeadline!),
              
              if (procedure.responsibleOffice != null)
                _buildDetailSection('担当窓口', procedure.responsibleOffice!),
              
              const SizedBox(height: 24),
              
              Card(
                color: _getPriorityColor(procedure.priority).withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.priority_high,
                        color: _getPriorityColor(procedure.priority),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '優先度: ${_getPriorityLabel(procedure.priority)}',
                        style: TextStyle(
                          color: _getPriorityColor(procedure.priority),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'high':
        return '高';
      case 'medium':
        return '中';
      case 'low':
        return '低';
      default:
        return priority;
    }
  }
}