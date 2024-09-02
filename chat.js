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
