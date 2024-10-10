import { useState } from 'react';
import { project_backend } from 'declarations/project_backend';

function App() {
  const [artworkTitle, setArtworkTitle] = useState('');
  const [artworkCreator, setArtworkCreator] = useState('');
  const [artworkPrice, setArtworkPrice] = useState('');
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(false);

  function handleRegisterArtwork(event) {
    event.preventDefault();
    if (Number(artworkPrice) <= 0) {
      setMessage('Price must be a positive number.');
      return;
    }
    setLoading(true);
    project_backend.registerArtwork(artworkTitle, artworkCreator, Number(artworkPrice))
      .then((newArtwork) => {
        setMessage(`Artwork Registered: ${newArtwork.title} by ${newArtwork.creator} with ID: ${newArtwork.id}`);
        setArtworkTitle('');
        setArtworkCreator('');
        setArtworkPrice('');
      })
      .catch((error) => {
        setMessage(`Error registering artwork: ${error.message || error}`);
      })
      .finally(() => {
        setLoading(false);
      });
  }

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br />
      <br />
      <form action="#" onSubmit={handleRegisterArtwork}>
        <label htmlFor="title">Artwork Title: &nbsp;</label>
        <input
          id="title"
          value={artworkTitle}
          onChange={(e) => setArtworkTitle(e.target.value)}
          type="text"
          required
        />
        <br />
        <label htmlFor="creator">Creator: &nbsp;</label>
        <input
          id="creator"
          value={artworkCreator}
          onChange={(e) => setArtworkCreator(e.target.value)}
          type="text"
          required
        />
        <br />
        <label htmlFor="price">Price (in tokens): &nbsp;</label>
        <input
          id="price"
          value={artworkPrice}
          onChange={(e) => setArtworkPrice(e.target.value)}
          type="number"
          required
        />
        <br />
        <button type="submit" disabled={loading}>
          {loading ? 'Registering...' : 'Register Artwork'}
        </button>
      </form>
      <section id="message" aria-live="polite">{message}</section>
    </main>
  );
}

export default App;
