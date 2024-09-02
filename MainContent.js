import React, { useEffect } from 'react';
import Tabs from './Tabs';
import RealTimeOdds from './RealTimeOdds';
import AIAnalysis from './AIAnalysis';
import CommandLine from './CommandLine';
import Chat from './Chat';
import HorseData from './HorseData';
import TrainerData from './TrainerData';
import TrackData from './TrackData';
import RiderData from './RiderData';
import WeatherData from './WeatherData';

const MainContent = () => {
  useEffect(() => {
    // Initialize the page
    populateTables();
    updateRealTimeOdds();
    setInterval(updateRealTimeOdds, 30000); // Update odds every 30 seconds
    updateChart('Select a horse');
    initWebSocket();
  }, []);

  const tabs = [
    { id: 'horseData', label: 'Horse Database', content: <HorseData /> },
    { id: 'trainerData', label: 'Trainers', content: <TrainerData /> },
    { id: 'trackData', label: 'Track Data', content: <TrackData /> },
    { id: 'riderData', label: 'Riders', content: <RiderData /> },
    { id: 'weatherData', label: 'Weather', content: <WeatherData /> },
  ];

  return (
    <div className="main-content">
      <div className="chart-container" id="chart_container">
        {/* Chart will be inserted here */}
      </div>
      <Tabs tabs={tabs} />
      <RealTimeOdds />
      <AIAnalysis />
      <CommandLine />
      <Chat />
    </div>
  );
};

export default MainContent;
