#!/bin/bash

# Create project directory
mkdir -p horse-racing-prediction
cd horse-racing-prediction

# Initialize a new Next.js project
npx create-next-app@latest . --use-npm --ts

# Install necessary dependencies
npm install mongoose pinecone-client

# Create components directory and files
mkdir -p components
cat <<EOL > components/AIAnalysis.js
import React from 'react';

const AIAnalysis = () => {
  return (
    <div className="ai-analysis">
      <h3>AI-Generated Statistical Analysis</h3>
      <div id="aiAnalysis"></div>
    </div>
  );
};

export default AIAnalysis;
EOL

cat <<EOL > components/BettingSimulator.js
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
EOL

cat <<EOL > components/Chat.js
import React, { useState } from 'react';

const Chat = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');

  const sendMessage = async () => {
    if (input.trim()) {
      setMessages([...messages, { sender: 'You', text: input }]);
      setInput('');

      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ message: input }),
      });

      const data = await response.json();
      setMessages([...messages, { sender: 'You', text: input }, { sender: 'AI', text: data.response }]);
    }
  };

  return (
    <div className="chat-container">
      <h3>AI RAG Sturg Chat Agent</h3>
      <div className="chat-messages">
        {messages.map((msg, index) => (
          <p key={index}><strong>{msg.sender}:</strong> {msg.text}</p>
        ))}
      </div>
      <div className="chat-input">
        <input
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Ask the AI agent..."
        />
        <button onClick={sendMessage}>Send</button>
      </div>
    </div>
  );
};

export default Chat;
EOL

cat <<EOL > components/CommandLine.js
import React, { useState } from 'react';

const CommandLine = () => {
  const [output, setOutput] = useState('');
  const [command, setCommand] = useState('');

  const executeCommand = async () => {
    const response = await fetch('/api/command', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ command }),
    });

    const data = await response.json();
    setOutput(output + \`> \${command}\n\${data.response}\n\`);
    setCommand('');
  };

  return (
    <div className="command-line">
      <input
        type="text"
        value={command}
        onChange={(e) => setCommand(e.target.value)}
        onKeyDown={(e) => e.key === 'Enter' && executeCommand()}
        placeholder="Enter command..."
      />
      <div className="command-output">{output}</div>
    </div>
  );
};

export default CommandLine;
EOL

cat <<EOL > components/FormGuide.js
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
    document.getElementById('formAnalysis').innerHTML = \`
      <h3>Analysis for \${horseName}</h3>
      <p><strong>Jockey:</strong> \${jockeyName}</p>
      <p><strong>Track Condition:</strong> \${trackCondition}</p>
      <p><strong>Distance:</strong> \${distance}m</p>
      <p><strong>Last Performance:</strong> \${lastPerformance}</p>
      <p><strong>AI Recommendation:</strong> \${data.recommendation}</p>
      <p><strong>Win Probability:</strong> \${data.winProbability}%</p>
      <p><strong>Expected Return:</strong> \${data.expectedReturn}x</p>
    \`;
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
EOL

cat <<EOL > components/HorseData.js
import React from 'react';

const HorseData = () => (
  <table>
    <thead>
      <tr>
        <th>Horse Name</th>
        <th>Age</th>
        <th>Sex</th>
        <th>Wins</th>
        <th>Places</th>
        <th>Total Races</th>
      </tr>
    </thead>
    <tbody id="horseTableBody">
      {/* Horse data will be inserted here */}
    </tbody>
  </table>
);

export default HorseData;
EOL

cat <<EOL > components/TrainerData.js
import React from 'react';

const TrainerData = () => (
  <table>
    <thead>
      <tr>
        <th>Trainer Name</th>
        <th>Win Rate</th>
        <th>Top Horses</th>
        <th>Specialty</th>
      </tr>
    </thead>
    <tbody id="trainerTableBody">
      {/* Trainer data will be inserted here */}
    </tbody>
  </table>
);

export default TrainerData;
EOL

cat <<EOL > components/TrackData.js
import React from 'react';

const TrackData = () => (
  <table>
    <thead>
      <tr>
        <th>Track Name</th>
        <th>Length</th>
        <th>Surface</th>
        <th>Record Time</th>
      </tr>
    </thead>
    <tbody id="trackTableBody">
      {/* Track data will be inserted here */}
    </tbody>
  </table>
);

export default TrackData;
EOL

cat <<EOL > components/RiderData.js
import React from 'react';

const RiderData = () => (
  <table>
    <thead>
      <tr>
        <th>Rider Name</th>
        <th>Wins</th>
        <th>Win Rate</th>
        <th>Preferred Tracks</th>
      </tr>
    </thead>
    <tbody id="riderTableBody">
      {/* Rider data will be inserted here */}
    </tbody>
  </table>
);

export default RiderData;
EOL

cat <<EOL > components/WeatherData.js
import React from 'react';

const WeatherData = () => (
  <table>
    <thead>
      <tr>
        <th>Date</th>
        <th>Temperature</th>
        <th>Condition</th>
        <th>Wind Speed</th>
      </tr>
    </thead>
    <tbody id="weatherTableBody">
      {/* Weather data will be inserted here */}
    </tbody>
  </table>
);

export default WeatherData;
EOL

cat <<EOL > components/MainContent.js
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
EOL

cat <<EOL > components/RealTimeOdds.js
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
EOL

cat <<EOL > components/Sidebar.js
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
EOL

cat <<EOL > components/Tabs.js
import React, { useState } from 'react';

const Tabs = ({ tabs }) => {
  const [activeTab, setActiveTab] = useState(tabs[0].id);

  return (
    <div>
      <div className="tabs">
        {tabs.map((tab) => (
          <button
            key={tab.id}
            className={\`tab \${activeTab === tab.id ? 'active' : ''}\`}
            onClick={() => setActiveTab(tab.id)}
          >
            {tab.label}
          </button>
        ))}
      </div>
      {tabs.map((tab) => (
        <div key={tab.id} className={\`tab-content \${activeTab === tab.id ? 'active' : ''}\`}>
          {tab.content}
        </div>
      ))}
    </div>
  );
};

export default Tabs;
EOL

# Create pages directory and files
mkdir -p pages/api
cat <<EOL > pages/api/chat.js
import { pineconeClient } from '../../utils/pinecone';

export default async function handler(req, res) {
  if (req.method === 'POST') {
    const { message } = req.body;
    const response = await pineconeClient.query(message);
    res.status(200).json({ response });
  } else {
    res.status(405).end();
  }
}
EOL

cat <<EOL > pages/api/formAnalysis.js
export default async function handler(req, res) {
  if (req.method === 'POST') {
    const { horseName, jockeyName, trackCondition, distance, lastPerformance } = req.body;
    const analysis = generateMockAnalysis(horseName, jockeyName, trackCondition, distance, lastPerformance);
    res.status(200).json(analysis);
  } else {
    res.status(405).end();
  }
}

function generateMockAnalysis(horseName, jockeyName, trackCondition, distance, lastPerformance) {
  const winProbability = Math.floor(Math.random() * 60) + 20; // 20% to 80%
  const expectedReturn = (Math.random() * 3 + 1).toFixed(2); // 1x to 4x

  let recommendation;
  if (winProbability > 60) {
    recommendation = "Strong contender. Consider placing a bet.";
  } else if (winProbability > 40) {
    recommendation = "Average performance expected. Proceed with caution.";
  } else {
    recommendation = "Not favored for this race. Consider other options.";
  }

  return {
    recommendation,
    winProbability,
    expectedReturn
  };
}
EOL

cat <<EOL > pages/api/odds.js
export default async function handler(req, res) {
  if (req.method === 'GET') {
    const odds = generateRealTimeOdds();
    res.status(200).json(odds);
  } else {
    res.status(405).end();
  }
}

function generateRealTimeOdds() {
  const horses = ['Thunderbolt', 'Silver Arrow', 'Golden Hoof', 'Midnight Runner', 'Desert Wind', 'Storm Chaser', 'Velvet Lightning', 'Iron Hoof'];
  return horses.map(name => ({
    name,
    odds: (Math.random() * 10 + 1).toFixed(2)
  }));
}
EOL

cat <<EOL > pages/api/simulateBet.js
export default async function handler(req, res) {
  if (req.method === 'POST') {
    const { betType, betAmount, selectedHorses } = req.body;
    const resultMessage = simulateBet(betType, betAmount, selectedHorses);
    res.status(200).json({ resultMessage });
  } else {
    res.status(405).end();
  }
}

function simulateBet(betType, betAmount, selectedHorses) {
  let winProbability, payoutMultiplier;

  switch(betType) {
    case 'win':
      winProbability = 0.2;
      payoutMultiplier = (Math.random() * 5 + 2).toFixed(2); // 2x to 7x
      break;
    case 'place':
      winProbability = 0.3;
      payoutMultiplier = (Math.random() * 3 + 1.5).toFixed(2); // 1.5x to 4.5x
      break;
    case 'show':
      winProbability = 0.4;
      payoutMultiplier = (Math.random() * 2 + 1.2).toFixed(2); // 1.2x to 3.2x
      break;
    case 'exacta':
      winProbability = 0.05;
      payoutMultiplier = (Math.random() * 20 + 10).toFixed(2); // 10x to 30x
      break;
    case 'trifecta':
      winProbability = 0.01;
      payoutMultiplier = (Math.random() * 50 + 30).toFixed(2); // 30x to 80x
      break;
    default:winProbability = 0.2;
      payoutMultiplier = (Math.random() * 5 + 2).toFixed(2); // 2x to 7x
  }

  if (Math.random() < winProbability) {
    const winnings = (betAmount * payoutMultiplier).toFixed(2);
    return \`Congratulations! You won \$\${winnings} on your \${betType} bet. (\${payoutMultiplier}x payout)\`;
  } else {
    return \`Sorry, you lost \$\${betAmount.toFixed(2)} on your \${betType} bet. Better luck next time!\`;
  }
}
EOL

# Create pages directory and files
cat <<EOL > pages/_app.js
import '../public/styles/globals.css';

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />;
}

export default MyApp;
EOL

cat <<EOL > pages/index.js
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
EOL

cat <<EOL > pages/_document.js
import { Html, Head, Main, NextScript } from 'next/document';

export default function Document() {
  return (
    <Html lang="en">
      <Head>
        <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
        />
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
EOL

# Create public/styles directory and global styles file
mkdir -p public/styles
cat <<EOL > public/styles/globals.css
:root {
  --primary-color: #1e2a3a;
  --secondary-color: #2c3e50;
  --accent-color: #3498db;
  --text-color: #ecf0f1;
  --positive-color: #2ecc71;
  --negative-color: #e74c3c;
  --neutral-color: #f39c12;
  --select-bg: #34495e;
  --select-hover: #2c3e50;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: var(--primary-color);
  color: var(--text-color);
  line-height: 1.6;
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.container {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.sidebar {
  width: 300px;
  background-color: var(--secondary-color);
  padding: 20px;
  overflow-y: auto;
  border-right: 1px solid var(--accent-color);
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

h2, h3 {
  margin-bottom: 15px;
  color: var(--accent-color);
}

ul {
  list-style-type: none;
}

li {
  margin-bottom: 10px;
}

button {
  width: 100%;
  padding: 10px;
  background-color: var(--accent-color);
  color: var(--text-color);
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: bold;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  text-align: left;
}

button:hover {
  background-color: #2980b9;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

button.active {
  background-color: #2ecc71;
}

button i {
  margin-right: 8px;
  font-size: 1.2em;
}

.chart-container {
  height: 40vh;
  margin-bottom: 20px;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.tabs {
  display: flex;
  justify-content: space-around;
  margin-bottom: 20px;
}

.tab {
  padding: 10px 20px;
  background-color: var(--secondary-color);
  color: var(--text-color);
  border: none;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.tab:hover, .tab.active {
  background-color: var(--accent-color);
}

.tab-content {
  display: none;
  background-color: var(--secondary-color);
  padding: 20px;
  border-radius: 5px;
}

.tab-content.active {
  display: block;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid var(--accent-color);
}

th {
  background-color: var(--select-bg);
}

.form-guide {
  background-color: var(--secondary-color);
  padding: 20px;
  border-radius: 5px;
  margin-bottom: 20px;
}

.form-guide input, .form-guide select {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  background-color: var(--primary-color);
  border: 1px solid var(--accent-color);
  color: var(--text-color);
  border-radius: 5px;
}

.form-guide button {
  background-color: var(--positive-color);
}

.form-guide button:hover {
  background-color: #27ae60;
}

.real-time-odds {
  background-color: var(--secondary-color);
  padding: 20px;
  border-radius: 5px;
  margin-top: 20px;
}

.odds-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 10px;
}

.odds-item {
  background-color: var(--primary-color);
  padding: 10px;
  border-radius: 5px;
  text-align: center;
}

.odds-item .horse-name {
  font-weight: bold;
  margin-bottom: 5px;
}

.odds-item .odds {
  font-size: 1.2em;
  color: var(--positive-color);
}

.ai-analysis {
  background-color: var(--secondary-color);
  padding: 20px;
  border-radius: 5px;
  margin-top: 20px;
}

.ai-analysis h3 {
  color: var(--accent-color);
  margin-bottom: 10px;
}

.ai-analysis p {
  margin-bottom: 10px;
}

.ai-analysis .prediction {
  font-weight: bold;
  color: var(--positive-color);
}

.ai-analysis .confidence {
  font-style: italic;
  color: var(--neutral-color);
}

.betting-simulator {
  background-color: var(--secondary-color);
  padding: 20px;
  border-radius: 5px;
  margin-top: 20px;
}

.betting-simulator h3 {
  color: var(--accent-color);
  margin-bottom: 10px;
}

.betting-simulator input, .betting-simulator select {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  background-color: var(--primary-color);
  border: 1px solid var(--accent-color);
  color: var(--text-color);
  border-radius: 5px;
}

.betting-simulator button {
  background-color: var(--positive-color);
  margin-bottom: 10px;
}

.betting-simulator button:hover {
  background-color: #27ae60;
}

.betting-result {
  font-weight: bold;
  margin-top: 10px;
}

.command-line {
  background-color: var(--secondary-color);
  color: var(--text-color);
  padding: 20px;
  border-radius: 5px;
  margin-top: 20px;
  font-family: 'Courier New', Courier, monospace;
}

.command-line input {
  width: 100%;
  padding: 10px;
  background-color: var(--primary-color);
  border: 1px solid var(--accent-color);
  color: var(--text-color);
  font-family: inherit;
}

.command-output {
  margin-top: 10px;
  white-space: pre-wrap;
}

@media (max-width: 768px) {
  .container {
    flex-direction: column;
  }
  
  .sidebar {
    width: 100%;
    height: auto;
  }
  
  .chart-container {
    height: 50vh;
  }
}

.chat-container {
  background-color: var(--secondary-color);
  padding: 20px;
  border-radius: 5px;
  margin-top: 20px;
  display: flex;
  flex-direction: column;
  height: 300px;
}

.chat-messages {
  flex-grow: 1;
  overflow-y: auto;
  margin-bottom: 10px;
}

.chat-input {
  display: flex;
}

.chat-input input {
  flex-grow: 1;
  padding: 10px;
  background-color: var(--primary-color);
  border: 1px solid var(--accent-color);
  color: var(--text-color);
  border-radius: 5px 0 0 5px;
}

.chat-input button {
  padding: 10px 20px;
  background-color: var(--accent-color);
  color: var(--text-color);
  border: none;
  border-radius: 0 5px 5px 0;
  cursor: pointer;
}
EOL

# Create utils directory and files
mkdir -p utils
cat <<EOL > utils/db.js
import mongoose from 'mongoose';

const MONGODB_URI = process.env.MONGODB_URI;

if (!MONGODB_URI) {
  throw new Error(
    'Please define the MONGODB_URI environment variable inside .env.local'
  );
}

/**
 * Global is used here to maintain a cached connection across hot reloads
 * in development. This prevents connections growing exponentially
 * during API Route usage.
 */
let cached = global.mongoose;

if (!cached) {
  cached = global.mongoose = { conn: null, promise: null };
}

async function dbConnect() {
  if (cached.conn) {
    return cached.conn;
  }

  if (!cached.promise) {
    const opts = {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      bufferCommands: false,
    };

    cached.promise = mongoose.connect(MONGODB_URI, opts).then((mongoose) => {
      return mongoose;
    });
  }
  cached.conn = await cached.promise;
  return cached.conn;
}

export default dbConnect;
EOL

cat <<EOL > utils/pinecone.js
import { PineconeClient } from 'pinecone-client';

const pineconeClient = new PineconeClient({
  apiKey: process.env.PINECONE_API_KEY,
  environment: process.env.PINECONE_ENVIRONMENT,
});

export { pineconeClient };
EOL

# Create .env.local file
cat <<EOL > .env.local
MONGODB_URI=your_mongodb_connection_string
PINECONE_API_KEY=your_pinecone_api_key
PINECONE_ENVIRONMENT=your_pinecone_environment
EOL

echo "Project setup complete. Please update the .env.local file with your actual environment variables."
