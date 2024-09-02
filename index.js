import React from 'react';
import Sidebar from '../components/Sidebar';
import MainContent from '../components/MainContent';

export default function Home() {
  return (
    <div className="container">
      <Sidebar />
      <MainContent />
    </div>
  );
}
