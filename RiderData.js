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
