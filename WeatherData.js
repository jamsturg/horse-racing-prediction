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
