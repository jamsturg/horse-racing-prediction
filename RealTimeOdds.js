import React, { useEffect, useState } from 'react';

const RealTimeOdds = () => {
  const [odds, setOdds] = useState([]);

  const fetchOdds = async () => {
    const response = await fetch('/api/odds');
    const data = await response.json();
    setOdds(data);
  };

  useEffect(() => {
    fetchOdds();
    const interval = setInterval(fetchOdds, 30000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="real-time-odds">
      <h3>Real-Time Odds</h3>
      <div className="odds-grid">
        {odds.map((horse, index) => (
          <div key={index} className="odds-item">
            <div className="horse-name">{horse.name}</div>
            <div className="odds">{horse.odds}</div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default RealTimeOdds;
