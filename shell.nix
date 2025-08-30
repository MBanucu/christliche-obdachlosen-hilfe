{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs_20
  ];

  shellHook = ''
    # Check and initialize the project if needed
    if [ ! -f package.json ]; then
      echo "Initializing Node.js project..."
      npm init -y
      npm install express ejs
    fi

    # Create views directory if it doesn't exist
    if [ ! -d views ]; then
      mkdir views
    fi

    # Create index.ejs if it doesn't exist
    if [ ! -f views/index.ejs ]; then
      echo "Creating views/index.ejs..."
      cat <<EOF > views/index.ejs
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Link Buttons</title>
      <style>
        body {
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          margin: 0;
          background-color: #f0f0f0;
          flex-direction: column;
        }
        .button {
          display: inline-block;
          font-size: 24px;
          padding: 20px 40px;
          margin: 20px;
          background-color: #007bff;
          color: white;
          text-decoration: none;
          border-radius: 8px;
          text-align: center;
          transition: background-color 0.3s;
        }
        .button:hover {
          background-color: #0056b3;
        }
      </style>
    </head>
    <body>
      <a href="https://toolsharing.christliche-obdachlosen-hilfe.de/" class="button">Go to Tool Sharing</a>
      <a href="https://wiki.christliche-obdachlosen-hilfe.de/de/home" class="button">Go to Wiki</a>
      <a href="https://forum.christliche-obdachlosen-hilfe.de/" class="button">Go to Forum</a>
    </body>
    </html>
    EOF
    fi

    # Create app.js if it doesn't exist
    if [ ! -f app.js ]; then
      echo "Creating app.js..."
      cat <<EOF > app.js
    const express = require('express');
    const app = express();
    const port = 3000;

    app.set('view engine', 'ejs');

    app.get('/', (req, res) => {
      res.render('index');
    });

    app.listen(port, () => {
      console.log(\`Server running at http://localhost:\''${port}\`);
    });
    EOF
    fi

    echo "Setup complete! Node.js v20 environment with EJS is ready."
    echo "To start the server, run: node app.js"
    echo "Then open http://localhost:3000 in your browser."
  '';
}
