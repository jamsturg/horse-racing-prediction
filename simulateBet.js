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
    return `Congratulations! You won $${winnings} on your ${betType} bet. (${payoutMultiplier}x payout)`;
  } else {
    return `Sorry, you lost $${betAmount.toFixed(2)} on your ${betType} bet. Better luck next time!`;
  }
}
