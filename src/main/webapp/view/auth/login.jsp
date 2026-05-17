<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OJJ Acadêmico • Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #4a3580 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .login-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }
        
        .login-card:hover {
            transform: translateY(-5px);
        }
        
        .error-message {
            background: #fed7d7;
            color: #c53030;
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
            border-left: 4px solid #c53030;
        }
        
        .input-group {
            margin-bottom: 24px;
        }
        
        .input-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #4a3580;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #9e8abf;
        }
        
        .input-icon input {
            width: 100%;
            padding: 14px 15px 14px 48px;
            border: 2px solid #e2e0f0;
            border-radius: 12px;
            font-size: 15px;
            color: #333;
            transition: all 0.3s ease;
            background: #faf9ff;
        }
        
        .input-icon input:focus {
            border-color: #667eea;
            outline: none;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #4a3580);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(74, 53, 128, 0.3);
        }
        
        .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo h1 {
            font-size: 32px;
            color: #4a3580;
            margin-bottom: 5px;
        }
        
        .logo p {
            color: #9e8abf;
            font-size: 14px;
        }
        
        .footer {
            text-align: center;
            margin-top: 25px;
            font-size: 11px;
            color: #b0a8cc;
        }
        
        @media (max-width: 480px) {
            .login-card {
                padding: 30px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="logo">
            <h1> OJJ Acadêmico</h1>
            <p>Sistema Integrado de Gestão</p>
        </div>
        
        <div style="text-align: center; margin-bottom: 25px;">
            <span style="background: #f0ecff; padding: 5px 15px; border-radius: 20px; font-size: 12px; color: #4a3580;">ACESSO AO SISTEMA</span>
        </div>
        
        <% if(request.getAttribute("erro") != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("erro") %>
            </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="input-group">
                <label><i class="fas fa-user"></i> USUÁRIO</label>
                <div class="input-icon">
                    <i class="fas fa-envelope"></i>
                    <input type="text" name="username" placeholder="Digite seu usuário" required>
                </div>
            </div>
            
            <div class="input-group">
                <label><i class="fas fa-lock"></i> SENHA</label>
                <div class="input-icon">
                    <i class="fas fa-key"></i>
                    <input type="password" name="password" placeholder="Digite sua senha" required>
                </div>
            </div>
            
            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt"></i> ENTRAR
            </button>
        </form>
        
        <div class="footer">
            <p>© 2026 Universidade OJJ — Todos os direitos reservados</p>
            <p style="margin-top: 5px;">Desenvolvido com para excelência académica</p>
        </div>
    </div>
</body>
</html>