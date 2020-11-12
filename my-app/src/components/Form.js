import React, { useContext, useState, useEffect } from 'react';
import { TaskListContext } from '../context/TaskListContext';

const Form = ({ setStatus }) => {
  const { addTask, editTask, editItem, clearList } = useContext(
    TaskListContext
  );
  const [text, setText] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!editItem && text) {
      addTask(text);
      setText('');
    } else if (!text) {
      alert('Please enter something 🤗🤗🤗');
    } else {
      editTask(text, editItem.id);
    }
  };

  const handleChange = (e) => {
    setText(e.target.value);
  };

  useEffect(() => {
    if (editItem) {
      setText(editItem.text);
    } else {
      setText('');
    }
  }, [editItem]);

  const statusHandler = (e) => {
    setStatus(e.target.value);
  };
  return (
    <div className="form-container">
      <form className="input-form">
        <div className="input-add">
          <input
            value={text}
            onChange={handleChange}
            type="text"
            className="task-input"
            placeholder="Add a new task"
          />
          <button onClick={handleSubmit} className="task-button" type="submit">
            {editItem ? (
              <i className="fas fa-pen"></i>
            ) : (
              <i className="fas fa-plus-square"></i>
            )}
          </button>
        </div>

        <div className="select-clean">
          <select onChange={statusHandler} name="tasks" className="filter-task">
            <option value="all">All</option>
            <option value="completed">Completed</option>
            <option value="uncompleted">Uncompleted</option>
          </select>
          <button
            className="trash-btn clear-btn"
            onClick={() =>
              window.confirm('Do you really want to clear everything? 🤔😈😱')
                ? clearList()
                : false
            }
          >
            <i className="fas fa-trash"></i>
          </button>
        </div>
      </form>
    </div>
  );
};

export default Form;
