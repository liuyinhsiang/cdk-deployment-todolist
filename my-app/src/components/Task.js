import React, { useContext } from 'react';
import { TaskListContext } from '../context/TaskListContext';

const Task = ({ task }) => {
  const { removeTask, findItem, toggleTask } = useContext(TaskListContext);

  return (
    <div className="task">
      <div className="task-info">
        {task.completed ? (
          <button
            className="complete-btn complete-checked"
            onClick={() => toggleTask(task.id)}
          >
            <i className="fas fa-check-circle"></i>
          </button>
        ) : (
          <button className="complete-btn" onClick={() => toggleTask(task.id)}>
            <i className="far fa-circle"></i>
          </button>
        )}
        <div className={`task-text ${task.completed ? 'completed' : ''}`}>
          {task.text}
        </div>
      </div>
      <div className="task-control">
        <button className="edit-btn" onClick={() => findItem(task.id)}>
          <i className="fas fa-pen"></i>
        </button>
        <button className="trash-btn" onClick={() => removeTask(task.id)}>
          <i className="fas fa-trash"></i>
        </button>
      </div>
    </div>
  );
};

export default Task;
