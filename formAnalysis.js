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
