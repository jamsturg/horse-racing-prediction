import React from 'react';

const FormGuide = () => {
  const analyzeForm = async () => {
    const horseName = document.getElementById('horseName').value;
    const jockeyName = document.getElementById('jockeyName').value;
    const trackCondition = document.getElementById('trackCondition').value;
    const distance = document.getElementById('distance').value;
    const lastPerformance = document.getElementById('lastPerformance').value;

    const response = await fetch('/api/formAnalysis', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ horseName, jockeyName, trackCondition, distance, lastPerformance }),
    });

    const data = await response.json();
    document.getElementById('formAnalysis').innerHTML = `
      <h3>Analysis for ${horseName}</h3>
      <p><strong>Jockey:</strong> ${jockeyName}</p>
      <p><strong>Track Condition:</strong> ${trackCondition}</p>
      <p><strong>Distance:</strong> ${distance}m</p>
      <p><strong>Last Performance:</strong> ${lastPerformance}</p>
      <p><strong>AI Recommendation:</strong> ${data.recommendation}</p>
      <p><strong>Win Probability:</strong> ${data.winProbability}%</p>
      <p><strong>Expected Return:</strong> ${data.expectedReturn}x</p>
    `;
  };

  return (
    <div className="form-guide">
      <input type="text" id="horseName" placeholder="Horse Name" />
      <input type="text" id="jockeyName" placeholder="Jockey Name" />
      <select id="trackCondition">
        <option value="">Select Track Condition</option>
        <option value="fast">Fast</option>
        <option value="good">Good</option>
        <option value="soft">Soft</option>
        <option value="heavy">Heavy</option>
      </select>
      <input type="number" id="distance" placeholder="Distance (m)" />
      <input type="text" id="lastPerformance" placeholder="Last Performance" />
      <button onClick={analyzeForm}>Analyze Form</button>
      <div id="formAnalysis"></div>
    </div>
  );
};

export default FormGuide;
