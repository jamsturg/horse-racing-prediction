import React from 'react';

const BettingSimulator = () => {
  const simulateBet = async () => {
    const betType = document.getElementById('betType').value;
    const betAmount = parseFloat(document.getElementById('betAmount').value);
    const selectedHorses = document.getElementById('selectedHorses').value.split(',').map(h => h.trim());

    if (isNaN(betAmount) || betAmount <= 0) {
      alert('Please enter a valid bet amount.');
      return;
    }

    if (selectedHorses.length === 0) {
      alert('Please select at least one horse.');
      return;
    }

    const response = await fetch('/api/simulateBet', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ betType, betAmount, selectedHorses }),
    });

    const data = await response.json();
    document.getElementById('bettingResult').innerHTML = data.resultMessage;
  };

  return (
    <div className="betting-simulator">
      <h3>Advanced Betting Simulator</h3>
      <select id="betType">
        <option value="win">Win</option>
        <option value="place">Place</option>
        <option value="show">Show</option>
        <option value="exacta">Exacta</option>
        <option value="trifecta">Trifecta</option>
      </select>
      <input type="number" id="betAmount" placeholder="Enter bet amount" />
      <input type="text" id="selectedHorses" placeholder="Horse number(s) (comma-separated)" />
      <button onClick={simulateBet}>Place Bet</button>
      <div id="bettingResult" className="betting-result"></div>
    </div>
  );
};

export default BettingSimulator;
