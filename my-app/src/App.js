import React, { useState, useEffect, useContext } from 'react';

import { TaskListContext } from './context/TaskListContext';
import Form from './components/Form';
import TaskList from './components/TaskList';
import './App.css';

const App = () => {
  const { tasks } = useContext(TaskListContext);
  const [status, setStatus] = useState('all');
  const [filteredTasks, setFilteredTasks] = useState([]);

  useEffect(() => {
    const filterHandler = () => {
      switch (status) {
        case 'completed':
          setFilteredTasks(tasks.filter((task) => task.completed === true));
          break;
        case 'uncompleted':
          setFilteredTasks(tasks.filter((task) => task.completed === false));
          break;
        default:
          setFilteredTasks(tasks);
          break;
      }
    };

    filterHandler();
  }, [tasks, status]);

  return (
    <div className="container">
      <header className="task-header">
        <h1>Task Management</h1>
      </header>
      <Form setStatus={setStatus} />
      <TaskList filteredTasks={filteredTasks} status={status} />
    </div>
  );
};

export default App;
