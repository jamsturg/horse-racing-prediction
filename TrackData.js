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
