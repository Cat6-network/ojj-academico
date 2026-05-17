<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sistema Académico OJJ — Login</title>
  <link rel="stylesheet" href="./css/styles.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>

  <div class="card">

    <!-- Painel esquerdo -->
    <div class="panel-left">
      <div class="panel-left__content">
        <div class="logo-icon">
          <i class="fa-solid fa-graduation-cap"></i>
        </div>
        <h2>Olá, Bem&#8209;vindo!</h2>
        <span class="brand-name">Sistema Académico</span>
        <span class="brand-abbr">OJJ</span>
        <p class="brand-tagline">Acesso seguro à plataforma académica</p>
      </div>
      <div class="blob blob-1"></div>
      <div class="blob blob-2"></div>
    </div>

    <!-- Painel direito -->
    <div class="panel-right">
      <h1 class="title">Login</h1>

      <form class="form" action="#" method="post">

        <div class="input-group">
          <input type="text" id="username" name="username" placeholder="Utilizador" required />
          <i class="fa-regular fa-user input-icon"></i>
        </div>

        <div class="input-group">
          <input type="password" id="password" name="password" placeholder="Palavra-passe" required />
          <i class="fa-solid fa-lock input-icon"></i>
        </div>

        <a href="#" class="forgot">Esqueceu a palavra-passe?</a>

        <button type="submit" class="btn-login">Entrar</button>

      </form>
    </div>

  </div>

</body>
</html>
