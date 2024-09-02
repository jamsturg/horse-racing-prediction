import React from 'react';
import FormGuide from './FormGuide';
import BettingSimulator from './BettingSimulator';

const Sidebar = () => {
  return (
    <div className="sidebar">
      <h2>Form Guide</h2>
      <FormGuide />
      <BettingSimulator />
    </div>
  );
};

export default Sidebar;
