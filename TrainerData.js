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
