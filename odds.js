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
