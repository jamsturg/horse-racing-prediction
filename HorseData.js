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
