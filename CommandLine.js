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
    setOutput(output + `> ${command}\n${data.response}\n`);
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
