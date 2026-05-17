-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16-Maio-2026 às 22:13
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ojj_academico`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alunos_turma`
--

CREATE TABLE `alunos_turma` (
  `id_aluno_turma` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `data_inscricao` timestamp NOT NULL DEFAULT current_timestamp(),
  `situacao` enum('cursando','aprovado','reprovado','trancado') DEFAULT 'cursando'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `alunos_turma`
--

INSERT INTO `alunos_turma` (`id_aluno_turma`, `id_estudante`, `id_turma`, `data_inscricao`, `situacao`) VALUES
(1, 1, 1, '2026-05-16 19:20:13', 'cursando');

-- --------------------------------------------------------

--
-- Estrutura da tabela `atendimentos`
--

CREATE TABLE `atendimentos` (
  `id_atendimento` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `id_funcionario` int(11) NOT NULL,
  `tipo_atendimento` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_atendimento` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('aberto','resolvido','pendente') DEFAULT 'aberto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `calendario_academico`
--

CREATE TABLE `calendario_academico` (
  `id_evento` int(11) NOT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `id_disciplina` int(11) DEFAULT NULL,
  `tipo_evento` enum('prova','exame','defesa_final','matricula','reuniao','outro') NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_hora_inicio` datetime NOT NULL,
  `data_hora_fim` datetime DEFAULT NULL,
  `local` varchar(200) DEFAULT NULL,
  `criado_por` int(11) DEFAULT NULL COMMENT 'id utilizador (coordenador)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `calendario_academico`
--

INSERT INTO `calendario_academico` (`id_evento`, `id_curso`, `id_disciplina`, `tipo_evento`, `titulo`, `descricao`, `data_hora_inicio`, `data_hora_fim`, `local`, `criado_por`) VALUES
(1, 1, NULL, 'prova', 'Prova de Programação Java', NULL, '2026-06-15 09:00:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `config_global`
--

CREATE TABLE `config_global` (
  `id_config` int(11) NOT NULL,
  `ano_lectivo_corrente` varchar(9) NOT NULL,
  `semestre_corrente` tinyint(4) NOT NULL,
  `prazo_matricula_dias` int(11) DEFAULT 30,
  `taxa_juros_multa` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `config_global`
--

INSERT INTO `config_global` (`id_config`, `ano_lectivo_corrente`, `semestre_corrente`, `prazo_matricula_dias`, `taxa_juros_multa`) VALUES
(1, '2025/2026', 1, 30, 0.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `duracao_semestres` int(11) NOT NULL CHECK (`duracao_semestres` >= 1),
  `id_coordenador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `cursos`
--

INSERT INTO `cursos` (`id_curso`, `nome`, `duracao_semestres`, `id_coordenador`) VALUES
(1, 'Engenharia Informática', 8, NULL),
(2, 'Direito', 10, NULL),
(3, 'Medicina', 12, NULL),
(4, 'Administração', 8, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `defesas_finais`
--

CREATE TABLE `defesas_finais` (
  `id_defesa` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `titulo_trabalho` varchar(255) NOT NULL,
  `data_defesa` datetime NOT NULL,
  `local` varchar(200) DEFAULT NULL,
  `banca` text DEFAULT NULL,
  `nota_final` decimal(5,2) DEFAULT NULL CHECK (`nota_final` between 0 and 20),
  `status` enum('agendado','realizado','cancelado') DEFAULT 'agendado',
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamentos`
--

CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `disciplinas`
--

CREATE TABLE `disciplinas` (
  `id_disciplina` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `carga_horaria` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `semestre` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Semestre do curso em que a disciplina é leccionada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `disciplinas`
--

INSERT INTO `disciplinas` (`id_disciplina`, `nome`, `codigo`, `carga_horaria`, `id_curso`, `semestre`) VALUES
(1, 'Programação Java', 'INF101', 60, 1, 1),
(2, 'Banco de Dados', 'INF102', 60, 1, 1),
(3, 'Engenharia de Software', 'INF103', 45, 1, 2),
(4, 'Direito Constitucional', 'DIR101', 90, 2, 1),
(5, 'Anatomia Humana', 'MED101', 120, 3, 1),
(6, 'Gestão Financeira', 'ADM101', 60, 4, 1),
(7, 'Algoritmos e Estrutura de Dados', 'INF104', 60, 1, 1),
(8, 'Matemática Discreta', 'INF105', 60, 1, 1),
(9, 'Redes de Computadores', 'INF201', 60, 1, 2),
(10, 'Sistemas Operativos', 'INF202', 60, 1, 2),
(11, 'Cálculo', 'INF203', 45, 1, 2),
(12, 'Programação Orientada a Objectos', 'INF301', 60, 1, 3),
(13, 'Arquitectura de Computadores', 'INF302', 45, 1, 3),
(14, 'Inteligência Artificial', 'INF401', 60, 1, 4),
(15, 'Compiladores', 'INF402', 45, 1, 4),
(16, 'Segurança Informática', 'INF501', 60, 1, 5),
(17, 'Computação em Nuvem', 'INF502', 45, 1, 5),
(18, 'Desenvolvimento Web', 'INF601', 60, 1, 6),
(19, 'Gestão de Projectos de TI', 'INF602', 45, 1, 6),
(20, 'Estágio Curricular', 'INF701', 120, 1, 7),
(21, 'Projecto Final de Curso', 'INF801', 120, 1, 8),
(22, 'Introdução ao Direito', 'DIR102', 90, 2, 1),
(23, 'Teoria do Estado', 'DIR103', 60, 2, 1),
(24, 'Direito Civil I', 'DIR201', 90, 2, 2),
(25, 'Direito Penal I', 'DIR202', 90, 2, 2),
(26, 'Direito Civil II', 'DIR301', 90, 2, 3),
(27, 'Direito Penal II', 'DIR302', 90, 2, 3),
(28, 'Direito do Trabalho', 'DIR401', 75, 2, 4),
(29, 'Direito Comercial', 'DIR402', 75, 2, 4),
(30, 'Direito Administrativo', 'DIR501', 75, 2, 5),
(31, 'Direito Internacional Público', 'DIR502', 60, 2, 5),
(32, 'Processo Civil', 'DIR601', 90, 2, 6),
(33, 'Processo Penal', 'DIR602', 90, 2, 6),
(34, 'Direito Fiscal', 'DIR701', 60, 2, 7),
(35, 'Direito da Família', 'DIR702', 60, 2, 7),
(36, 'Prática Jurídica', 'DIR801', 120, 2, 8),
(37, 'Direito Ambiental', 'DIR802', 60, 2, 8),
(38, 'Estágio Forense', 'DIR901', 150, 2, 9),
(39, 'Monografia', 'DIR1001', 180, 2, 10),
(40, 'Bioquímica', 'MED102', 120, 3, 1),
(41, 'Biofísica', 'MED103', 90, 3, 1),
(42, 'Fisiologia I', 'MED201', 120, 3, 2),
(43, 'Histologia', 'MED202', 90, 3, 2),
(44, 'Fisiologia II', 'MED301', 120, 3, 3),
(45, 'Microbiologia', 'MED302', 90, 3, 3),
(46, 'Patologia Geral', 'MED401', 120, 3, 4),
(47, 'Farmacologia I', 'MED402', 90, 3, 4),
(48, 'Patologia Especial', 'MED501', 120, 3, 5),
(49, 'Farmacologia II', 'MED502', 90, 3, 5),
(50, 'Semiologia', 'MED601', 120, 3, 6),
(51, 'Clínica Médica I', 'MED701', 150, 3, 7),
(52, 'Cirurgia I', 'MED702', 150, 3, 7),
(53, 'Clínica Médica II', 'MED801', 150, 3, 8),
(54, 'Cirurgia II', 'MED802', 150, 3, 8),
(55, 'Pediatria', 'MED901', 120, 3, 9),
(56, 'Ginecologia e Obstetrícia', 'MED902', 120, 3, 9),
(57, 'Psiquiatria', 'MED1001', 90, 3, 10),
(58, 'Medicina Interna', 'MED1002', 120, 3, 10),
(59, 'Estágio Hospitalar I', 'MED1101', 200, 3, 11),
(60, 'Estágio Hospitalar II', 'MED1201', 200, 3, 12),
(61, 'Defesa de Tese', 'MED1202', 60, 3, 12),
(62, 'Contabilidade Geral', 'ADM102', 60, 4, 1),
(63, 'Matemática Financeira', 'ADM103', 60, 4, 1),
(64, 'Economia I', 'ADM201', 60, 4, 2),
(65, 'Direito Empresarial', 'ADM202', 60, 4, 2),
(66, 'Economia II', 'ADM301', 60, 4, 3),
(67, 'Marketing I', 'ADM302', 60, 4, 3),
(68, 'Gestão de Recursos Humanos', 'ADM401', 60, 4, 4),
(69, 'Marketing II', 'ADM402', 60, 4, 4),
(70, 'Logística e Cadeia de Abastecimento', 'ADM501', 60, 4, 5),
(71, 'Empreendedorismo', 'ADM502', 45, 4, 5),
(72, 'Gestão de Operações', 'ADM601', 60, 4, 6),
(73, 'Auditoria', 'ADM602', 60, 4, 6),
(74, 'Estratégia Empresarial', 'ADM701', 60, 4, 7),
(75, 'Fiscalidade', 'ADM702', 60, 4, 7),
(76, 'Projecto de Fim de Curso', 'ADM801', 120, 4, 8);

-- --------------------------------------------------------

--
-- Estrutura da tabela `documentos_emitidos`
--

CREATE TABLE `documentos_emitidos` (
  `id_documento` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `tipo_documento` enum('declaracao_sem_notas','declaracao_com_notas','confirmacao_matricula','cartao_estudante','certificado_conclusao','carta_estagio_externo','certificado_curso') NOT NULL DEFAULT 'declaracao_sem_notas' COMMENT 'Tipo de documento emitido',
  `id_secretario` int(11) DEFAULT NULL COMMENT 'Secretário que emitiu o documento',
  `numero_documento` varchar(30) DEFAULT NULL COMMENT 'Número único gerado no momento da emissão',
  `data_emissao` timestamp NOT NULL DEFAULT current_timestamp(),
  `conteudo` text DEFAULT NULL,
  `incluir_notas` tinyint(1) DEFAULT 0,
  `id_servico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estudantes`
--

CREATE TABLE `estudantes` (
  `id_estudante` int(11) NOT NULL,
  `bi` varchar(14) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `nif` varchar(12) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_matricula` date DEFAULT curdate(),
  `status` enum('Activo','Trancado','Suspenso','Concluido','Desistente','Expulso') DEFAULT 'Activo',
  `id_curso` int(11) DEFAULT NULL,
  `matriculado_por` int(11) DEFAULT NULL,
  `ano_suspenso` varchar(9) DEFAULT NULL,
  `motivo_suspensao` text DEFAULT NULL,
  `data_suspensao` date DEFAULT NULL,
  `ano_conclusao` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `estudantes`
--

INSERT INTO `estudantes` (`id_estudante`, `bi`, `nome`, `nif`, `email`, `telefone`, `data_matricula`, `status`, `id_curso`, `matriculado_por`, `ano_suspenso`, `motivo_suspensao`, `data_suspensao`, `ano_conclusao`) VALUES
(1, '00123456789AB0', 'João Manuel da Silva', '5001234567', 'joao.silva@estudante.ojj.ao', '923456789', '2026-05-16', 'Activo', 1, NULL, NULL, NULL, NULL, NULL),
(2, '00234567890BC1', 'Mariana de Jesus Santos', '5002345678', 'mariana.santos@estudante.ojj.ao', '934567890', '2026-05-16', 'Activo', 2, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id_funcionario` int(11) NOT NULL,
  `bi` varchar(14) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `departamento` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `nif` varchar(12) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL COMMENT 'Caminho relativo para a foto de perfil',
  `tipo_funcionario` enum('admin','professor','secretario','tesoureiro','coordenador_curso','coordenador_departamento','rh') NOT NULL,
  `data_admissao` date DEFAULT curdate(),
  `activo` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = activo  |  0 = desactivado',
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id_funcionario`, `bi`, `nome`, `cargo`, `departamento`, `email`, `telefone`, `nif`, `foto`, `tipo_funcionario`, `data_admissao`, `activo`, `id_departamento`) VALUES
(1, '10000000000AA0', 'Administrador Geral', 'Admin', 'TI', 'admin@ojj.ao', '923000001', '1000000001', NULL, 'admin', '2026-05-16', 1, NULL),
(2, '20000000000BB1', 'Ana Paula Sebastião', 'Secretária', 'Secretaria', 'ana.secretaria@ojj.ao', '923000002', '2000000002', NULL, 'secretario', '2026-05-16', 1, NULL),
(3, '30000000000CC2', 'Carlos Alberto Fernandes', 'Tesoureiro', 'Financeiro', 'carlos.tesoureiro@ojj.ao', '923000003', '3000000003', NULL, 'tesoureiro', '2026-05-16', 1, NULL),
(4, '40000000000DD3', 'Maria Helena Campos', 'Coordenadora de Curso', 'Eng. Informática', 'maria.coordenadora@ojj.ao', '923000004', '4000000004', NULL, 'coordenador_curso', '2026-05-16', 1, NULL),
(5, '50000000000EE4', 'José Eduardo dos Santos', 'Professor', 'Eng. Informática', 'jose.professor@ojj.ao', '923000005', '5000000005', NULL, 'professor', '2026-05-16', 1, NULL),
(6, '60000000000FF5', 'António Filipe Marques', 'Professor', 'Eng. Informática', 'antonio.marques@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(7, '70000000000GG6', 'Beatriz Carvalho Neto', 'Professora', 'Eng. Informática', 'beatriz.neto@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(8, '80000000000HH7', 'Celestino Paulo Afonso', 'Professor', 'Eng. Informática', 'celestino.afonso@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(9, '90000000000II8', 'Domingos Lopes Vieira', 'Professor', 'Direito', 'domingos.vieira@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(10, '11000000000JJ9', 'Esperança Teixeira Sousa', 'Professora', 'Direito', 'esperanca.sousa@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(11, '12000000000KK0', 'Fernando Augusto Pinto', 'Professor', 'Direito', 'fernando.pinto@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(12, '13000000000LL1', 'Graça Mendes Ribeiro', 'Professora', 'Medicina', 'graca.ribeiro@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(13, '14000000000MM2', 'Hélder Nunes Ferreira', 'Professor', 'Medicina', 'helder.ferreira@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(14, '15000000000NN3', 'Isaura Rodrigues Lima', 'Professora', 'Medicina', 'isaura.lima@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(15, '16000000000OO4', 'Joaquim Baptista Costa', 'Professor', 'Administração', 'joaquim.costa@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL),
(16, '17000000000PP5', 'Kátia Morais Pereira', 'Professora', 'Administração', 'katia.pereira@ojj.ao', NULL, NULL, NULL, 'professor', '2026-05-16', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `historico_status_estudante`
--

CREATE TABLE `historico_status_estudante` (
  `id_historico` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `status_anterior` varchar(20) DEFAULT NULL,
  `status_novo` varchar(20) NOT NULL,
  `motivo` text DEFAULT NULL,
  `id_secretario` int(11) DEFAULT NULL COMMENT 'Secretário que registou a alteração',
  `data_alteracao` timestamp NOT NULL DEFAULT current_timestamp(),
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Histórico completo de todas as alterações de estado dos estudantes';

-- --------------------------------------------------------

--
-- Estrutura da tabela `logs_operacoes`
--

CREATE TABLE `logs_operacoes` (
  `id_log` int(11) NOT NULL,
  `id_utilizador` int(11) NOT NULL,
  `id_ref_estudante` int(11) DEFAULT NULL,
  `operacao` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `detalhes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`detalhes`)),
  `ip_origem` varchar(45) DEFAULT NULL,
  `data_hora` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `matriculas`
--

CREATE TABLE `matriculas` (
  `id_matricula` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `ano_lectivo` varchar(9) NOT NULL,
  `semestre` tinyint(4) NOT NULL,
  `data_matricula` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activa','trancada','cancelada') DEFAULT 'activa',
  `id_secretario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `notas`
--

CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `nota1` decimal(5,2) DEFAULT NULL CHECK (`nota1` between 0 and 20),
  `nota2` decimal(5,2) DEFAULT NULL CHECK (`nota2` between 0 and 20),
  `nota_final` decimal(5,2) DEFAULT NULL CHECK (`nota_final` between 0 and 20),
  `semestre` varchar(10) NOT NULL,
  `status_pauta` enum('rascunho','enviado','aprovado','reprovado') NOT NULL DEFAULT 'rascunho',
  `aprovado_por` int(11) DEFAULT NULL COMMENT 'id do coordenador que aprovou',
  `data_aprovacao` timestamp NULL DEFAULT NULL,
  `justificacao_reprovacao` text DEFAULT NULL,
  `id_turma` int(11) DEFAULT NULL COMMENT 'Turma em que a nota foi atribuída',
  `id_professor_lancamento` int(11) DEFAULT NULL COMMENT 'Professor que lançou a nota',
  `id_pauta` int(11) DEFAULT NULL COMMENT 'Pauta a que esta nota pertence'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `notas`
--

INSERT INTO `notas` (`id_nota`, `id_estudante`, `id_disciplina`, `nota1`, `nota2`, `nota_final`, `semestre`, `status_pauta`, `aprovado_por`, `data_aprovacao`, `justificacao_reprovacao`, `id_turma`, `id_professor_lancamento`, `id_pauta`) VALUES
(1, 1, 1, 15.50, 16.00, 15.80, '2025.1', 'rascunho', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 2, 14.00, 13.50, 13.80, '2025.1', 'rascunho', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pagamentos`
--

CREATE TABLE `pagamentos` (
  `id_pagamento` int(11) NOT NULL,
  `id_estudante` int(11) NOT NULL,
  `id_servico` int(11) DEFAULT NULL,
  `valor_kz` decimal(12,2) NOT NULL,
  `data_pagamento` timestamp NOT NULL DEFAULT current_timestamp(),
  `referencia` varchar(50) DEFAULT NULL,
  `status` enum('pendente','pago','cancelado') DEFAULT 'pendente',
  `metodo_pagamento` enum('numerario','transferencia','deposito_bancario','multicaixa') NOT NULL DEFAULT 'numerario' COMMENT 'Método de pagamento utilizado',
  `mes_referencia` varchar(7) DEFAULT NULL COMMENT 'Mês de referência no formato AAAA-MM (usado na propina mensal)',
  `numero_recibo` varchar(30) DEFAULT NULL COMMENT 'Número do recibo emitido pela tesouraria',
  `observacao` text DEFAULT NULL,
  `id_tesoureiro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `pagamentos`
--

INSERT INTO `pagamentos` (`id_pagamento`, `id_estudante`, `id_servico`, `valor_kz`, `data_pagamento`, `referencia`, `status`, `metodo_pagamento`, `mes_referencia`, `numero_recibo`, `observacao`, `id_tesoureiro`) VALUES
(1, 1, 1, 150000.00, '2026-05-16 19:20:12', 'REC-2025-001', 'pago', 'numerario', NULL, 'REC-2026-00001', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pautas`
--

CREATE TABLE `pautas` (
  `id_pauta` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `tipo_avaliacao` enum('1a_epoca','2a_epoca','recurso','especial') NOT NULL DEFAULT '1a_epoca',
  `ano_lectivo` varchar(9) NOT NULL,
  `semestre` tinyint(4) NOT NULL,
  `status` enum('rascunho','enviada','aprovada','reprovada') NOT NULL DEFAULT 'rascunho',
  `id_professor` int(11) NOT NULL COMMENT 'Professor que preencheu e enviou a pauta',
  `data_envio` datetime DEFAULT NULL COMMENT 'Data em que o professor enviou ao departamento',
  `id_coordenador_aprovacao` int(11) DEFAULT NULL COMMENT 'Coordenador que aprovou ou reprovou',
  `data_aprovacao` datetime DEFAULT NULL,
  `justificacao_reprovacao` text DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizado_em` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Documento formal de pauta: professor lança → envia → coordenador aprova';

-- --------------------------------------------------------

--
-- Estrutura da tabela `precos`
--

CREATE TABLE `precos` (
  `id_preco` int(11) NOT NULL,
  `tipo_servico` enum('matricula','propina_mensal','declaracao_sem_notas','declaracao_com_notas','confirmacao_matricula','cartao_estudante','certificado_conclusao','carta_estagio_externo','certificado_curso','multa_atraso','reposicao_cartao') NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `valor_kz` decimal(12,2) NOT NULL,
  `data_vigencia` date DEFAULT curdate(),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `precos`
--

INSERT INTO `precos` (`id_preco`, `tipo_servico`, `descricao`, `valor_kz`, `data_vigencia`, `activo`) VALUES
(1, 'matricula', 'Anuidade de matrícula', 15000.00, '2026-05-16', 1),
(2, 'propina_mensal', 'Propina mensal (10 meses)', 33000.00, '2026-05-16', 1),
(3, 'declaracao_sem_notas', 'Declaração de estudante (sem notas)', 4000.00, '2026-05-16', 1),
(4, 'declaracao_com_notas', 'Declaração de estudante (com notas)', 8500.00, '2026-05-16', 1),
(5, 'confirmacao_matricula', 'Certificado de confirmação de matrícula', 12000.00, '2026-05-16', 1),
(6, 'cartao_estudante', 'Emissão de cartão de estudante', 1000.00, '2026-05-16', 1),
(7, 'certificado_conclusao', 'Certificado de conclusão de curso', 35000.00, '2026-05-16', 1),
(8, 'carta_estagio_externo', 'Carta de estágio externo', 5000.00, '2026-05-16', 1),
(9, 'certificado_curso', 'Certificado de curso (por disciplina)', 12000.00, '2026-05-16', 1),
(10, 'multa_atraso', 'Multa por atraso de pagamento', 5000.00, '2026-05-16', 1),
(11, 'reposicao_cartao', '2ª via do cartão de estudante', 3000.00, '2026-05-16', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `precos_padrao`
--

CREATE TABLE `precos_padrao` (
  `id_preco_padrao` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `valor_kz` decimal(12,2) NOT NULL,
  `data_vigencia` date NOT NULL DEFAULT curdate(),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `precos_padrao`
--

INSERT INTO `precos_padrao` (`id_preco_padrao`, `id_servico`, `valor_kz`, `data_vigencia`, `activo`) VALUES
(1, 1, 150000.00, '2026-05-16', 1),
(2, 2, 120000.00, '2026-05-16', 1),
(3, 3, 2500.00, '2026-05-16', 1),
(4, 4, 3500.00, '2026-05-16', 1),
(5, 5, 2000.00, '2026-05-16', 1),
(6, 6, 1000.00, '2026-05-16', 1),
(7, 7, 15000.00, '2026-05-16', 1),
(8, 8, 5000.00, '2026-05-16', 1),
(9, 9, 12000.00, '2026-05-16', 1),
(10, 10, 5000.00, '2026-05-16', 1),
(11, 11, 2000.00, '2026-05-16', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `precos_por_curso`
--

CREATE TABLE `precos_por_curso` (
  `id_preco_curso` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `valor_kz` decimal(12,2) NOT NULL,
  `data_vigencia` date NOT NULL DEFAULT curdate(),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `precos_por_curso`
--

INSERT INTO `precos_por_curso` (`id_preco_curso`, `id_curso`, `id_servico`, `valor_kz`, `data_vigencia`, `activo`) VALUES
(1, 3, 2, 180000.00, '2026-05-16', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `servicos`
--

CREATE TABLE `servicos` (
  `id_servico` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `unidade` varchar(20) DEFAULT 'unidade'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `servicos`
--

INSERT INTO `servicos` (`id_servico`, `codigo`, `nome`, `unidade`) VALUES
(1, 'MATRICULA', 'Matrícula anual', 'ano'),
(2, 'PROPINA_MENSAL', 'Propina mensal', 'mês'),
(3, 'DECLARACAO_SEM_NOTAS', 'Declaração de estudante (sem notas)', 'unidade'),
(4, 'DECLARACAO_COM_NOTAS', 'Declaração de estudante (com notas)', 'unidade'),
(5, 'CONFIRMACAO_MATRICULA', 'Certificado de confirmação de matrícula', 'unidade'),
(6, 'CARTAO_ESTUDANTE', 'Cartão de estudante (1ª via)', 'unidade'),
(7, 'CERTIFICADO_CONCLUSAO', 'Certificado de conclusão de curso', 'unidade'),
(8, 'CARTA_ESTAGIO_EXTERNO', 'Carta de estágio externo', 'unidade'),
(9, 'CERTIFICADO_CURSO', 'Certificado de curso (por disciplina)', 'unidade'),
(10, 'MULTA_ATRASO', 'Multa por atraso de pagamento', 'ocorrência'),
(11, 'REPOSICAO_CARTAO', '2ª via do cartão de estudante', 'unidade');

-- --------------------------------------------------------

--
-- Estrutura da tabela `turmas`
--

CREATE TABLE `turmas` (
  `id_turma` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `ano_lectivo` varchar(9) NOT NULL,
  `semestre` tinyint(4) NOT NULL CHECK (`semestre` in (1,2)),
  `codigo_turma` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `turmas`
--

INSERT INTO `turmas` (`id_turma`, `id_disciplina`, `ano_lectivo`, `semestre`, `codigo_turma`) VALUES
(1, 1, '2025/2026', 1, 'T1'),
(2, 2, '2025/2026', 1, 'T1'),
(17, 3, '2025/2026', 2, 'T1'),
(5, 4, '2025/2026', 1, 'T1'),
(8, 5, '2025/2026', 1, 'T1'),
(11, 6, '2025/2026', 1, 'T1'),
(3, 7, '2025/2026', 1, 'T1'),
(4, 8, '2025/2026', 1, 'T1'),
(6, 22, '2025/2026', 1, 'T1'),
(7, 23, '2025/2026', 1, 'T1'),
(9, 40, '2025/2026', 1, 'T1'),
(10, 41, '2025/2026', 1, 'T1'),
(12, 62, '2025/2026', 1, 'T1'),
(13, 63, '2025/2026', 1, 'T1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `turma_professores`
--

CREATE TABLE `turma_professores` (
  `id_turma_professor` int(11) NOT NULL,
  `id_turma` int(11) NOT NULL,
  `id_professor` int(11) NOT NULL,
  `tipo` enum('titular','assistente','convidado') DEFAULT 'titular',
  `data_inicio` date DEFAULT curdate(),
  `data_fim` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Relação muitos-para-muitos entre turmas e professores';

--
-- Extraindo dados da tabela `turma_professores`
--

INSERT INTO `turma_professores` (`id_turma_professor`, `id_turma`, `id_professor`, `tipo`, `data_inicio`, `data_fim`) VALUES
(1, 1, 5, 'titular', '2026-05-16', NULL),
(6, 2, 6, 'titular', '2026-05-16', NULL),
(7, 3, 6, 'titular', '2026-05-16', NULL),
(8, 17, 7, 'titular', '2026-05-16', NULL),
(9, 4, 8, 'titular', '2026-05-16', NULL),
(10, 5, 9, 'titular', '2026-05-16', NULL),
(11, 6, 10, 'titular', '2026-05-16', NULL),
(12, 7, 11, 'titular', '2026-05-16', NULL),
(13, 8, 12, 'titular', '2026-05-16', NULL),
(14, 9, 13, 'titular', '2026-05-16', NULL),
(15, 10, 14, 'titular', '2026-05-16', NULL),
(16, 11, 15, 'titular', '2026-05-16', NULL),
(17, 12, 16, 'titular', '2026-05-16', NULL),
(18, 13, 15, 'titular', '2026-05-16', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizadores`
--

CREATE TABLE `utilizadores` (
  `id_utilizador` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `tipo_perfil` enum('Estudante','Funcionario') NOT NULL,
  `id_ref` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = pode entrar  |  0 = bloqueado',
  `senha_provisoria` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = deve alterar senha no próximo login',
  `ultimo_login` timestamp NULL DEFAULT NULL COMMENT 'Última vez que o utilizador fez login'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `utilizadores`
--

INSERT INTO `utilizadores` (`id_utilizador`, `username`, `senha_hash`, `tipo_perfil`, `id_ref`, `activo`, `senha_provisoria`, `ultimo_login`) VALUES
(1, 'admin', '$2a$10$r0.2Z7tZqQqS5wTqQqQqOeXqQqQqQqQqQqQqQqQqQqQqQqQqQqQq', 'Funcionario', 1, 1, 0, NULL),
(2, 'ana.secretaria', '$2a$10$XqXqXqXqXqXqXqXqXqXqXqOeXqQqQqQqQqQqQqQqQqQqQqQqXqXq', 'Funcionario', 2, 1, 1, NULL),
(3, 'carlos.tesoureiro', '$2a$10$Y3oUZxq9N4fdhHWMk6/loOLFZsrpuB.jhv.0sgi14wzg4s6fj.Nvq', 'Funcionario', 3, 1, 1, NULL),
(4, 'maria.coordenadora', '$2a$10$NkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6M7', 'Funcionario', 4, 1, 1, NULL),
(5, 'jose.professor', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 5, 1, 1, NULL),
(6, 'joao.silva', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Estudante', 1, 1, 1, NULL),
(7, 'mariana.santos', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Estudante', 2, 1, 1, NULL),
(8, 'antonio.marques', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 6, 1, 1, NULL),
(9, 'beatriz.neto', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 7, 1, 1, NULL),
(10, 'celestino.afonso', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 8, 1, 1, NULL),
(11, 'domingos.vieira', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 9, 1, 1, NULL),
(12, 'esperanca.sousa', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 10, 1, 1, NULL),
(13, 'fernando.pinto', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 11, 1, 1, NULL),
(14, 'graca.ribeiro', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 12, 1, 1, NULL),
(15, 'helder.ferreira', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 13, 1, 1, NULL),
(16, 'isaura.lima', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 14, 1, 1, NULL),
(17, 'joaquim.costa', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 15, 1, 1, NULL),
(18, 'katia.pereira', '$2a$10$RkM5C9bF7XqPpQ5R6S7T8U9V0W1X2Y3Z4A5B6C7D8E9F0G1H2I3J4K5L6N8', 'Funcionario', 16, 1, 1, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alunos_turma`
--
ALTER TABLE `alunos_turma`
  ADD PRIMARY KEY (`id_aluno_turma`),
  ADD UNIQUE KEY `unique_aluno_turma` (`id_estudante`,`id_turma`),
  ADD KEY `id_turma` (`id_turma`);

--
-- Índices para tabela `atendimentos`
--
ALTER TABLE `atendimentos`
  ADD PRIMARY KEY (`id_atendimento`),
  ADD KEY `fk_atendimento_estudante` (`id_estudante`),
  ADD KEY `fk_atendimento_funcionario` (`id_funcionario`);

--
-- Índices para tabela `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `id_disciplina` (`id_disciplina`);

--
-- Índices para tabela `config_global`
--
ALTER TABLE `config_global`
  ADD PRIMARY KEY (`id_config`);

--
-- Índices para tabela `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id_curso`),
  ADD UNIQUE KEY `nome` (`nome`),
  ADD KEY `fk_curso_coordenador` (`id_coordenador`);

--
-- Índices para tabela `defesas_finais`
--
ALTER TABLE `defesas_finais`
  ADD PRIMARY KEY (`id_defesa`),
  ADD KEY `id_estudante` (`id_estudante`);

--
-- Índices para tabela `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices para tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`id_disciplina`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Índices para tabela `documentos_emitidos`
--
ALTER TABLE `documentos_emitidos`
  ADD PRIMARY KEY (`id_documento`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD KEY `idx_documentos_estudante` (`id_estudante`),
  ADD KEY `fk_documentos_servico` (`id_servico`),
  ADD KEY `fk_doc_secretario` (`id_secretario`);

--
-- Índices para tabela `estudantes`
--
ALTER TABLE `estudantes`
  ADD PRIMARY KEY (`id_estudante`),
  ADD UNIQUE KEY `bi` (`bi`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nif` (`nif`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `fk_estudante_secretario` (`matriculado_por`);

--
-- Índices para tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id_funcionario`),
  ADD UNIQUE KEY `bi` (`bi`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nif` (`nif`),
  ADD KEY `fk_funcionario_departamento` (`id_departamento`);

--
-- Índices para tabela `historico_status_estudante`
--
ALTER TABLE `historico_status_estudante`
  ADD PRIMARY KEY (`id_historico`),
  ADD KEY `idx_hist_estudante` (`id_estudante`),
  ADD KEY `idx_hist_secretario` (`id_secretario`),
  ADD KEY `idx_hist_data` (`data_alteracao`);

--
-- Índices para tabela `logs_operacoes`
--
ALTER TABLE `logs_operacoes`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_utilizador` (`id_utilizador`),
  ADD KEY `idx_log_data` (`data_hora`);

--
-- Índices para tabela `matriculas`
--
ALTER TABLE `matriculas`
  ADD PRIMARY KEY (`id_matricula`),
  ADD KEY `fk_matricula_estudante` (`id_estudante`),
  ADD KEY `fk_matricula_secretario` (`id_secretario`);

--
-- Índices para tabela `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_nota`),
  ADD UNIQUE KEY `unique_nota` (`id_estudante`,`id_disciplina`,`semestre`),
  ADD KEY `id_disciplina` (`id_disciplina`),
  ADD KEY `fk_nota_turma` (`id_turma`),
  ADD KEY `fk_nota_professor` (`id_professor_lancamento`),
  ADD KEY `fk_nota_pauta` (`id_pauta`);

--
-- Índices para tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`id_pagamento`),
  ADD UNIQUE KEY `referencia` (`referencia`),
  ADD UNIQUE KEY `numero_recibo` (`numero_recibo`),
  ADD KEY `id_estudante` (`id_estudante`),
  ADD KEY `idx_pagamentos_status` (`status`),
  ADD KEY `fk_pagamentos_servico` (`id_servico`),
  ADD KEY `fk_pagamento_tesoureiro` (`id_tesoureiro`);

--
-- Índices para tabela `pautas`
--
ALTER TABLE `pautas`
  ADD PRIMARY KEY (`id_pauta`),
  ADD UNIQUE KEY `unique_pauta` (`id_turma`,`tipo_avaliacao`,`ano_lectivo`,`semestre`),
  ADD KEY `idx_pauta_professor` (`id_professor`),
  ADD KEY `idx_pauta_coordenador` (`id_coordenador_aprovacao`),
  ADD KEY `idx_pauta_status` (`status`);

--
-- Índices para tabela `precos`
--
ALTER TABLE `precos`
  ADD PRIMARY KEY (`id_preco`),
  ADD UNIQUE KEY `tipo_servico_activo` (`tipo_servico`,`activo`);

--
-- Índices para tabela `precos_padrao`
--
ALTER TABLE `precos_padrao`
  ADD PRIMARY KEY (`id_preco_padrao`),
  ADD UNIQUE KEY `servico_vigente` (`id_servico`,`activo`);

--
-- Índices para tabela `precos_por_curso`
--
ALTER TABLE `precos_por_curso`
  ADD PRIMARY KEY (`id_preco_curso`),
  ADD UNIQUE KEY `curso_servico_vigente` (`id_curso`,`id_servico`,`activo`),
  ADD KEY `id_servico` (`id_servico`);

--
-- Índices para tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id_servico`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Índices para tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`id_turma`),
  ADD UNIQUE KEY `unique_turma` (`id_disciplina`,`ano_lectivo`,`semestre`,`codigo_turma`);

--
-- Índices para tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  ADD PRIMARY KEY (`id_turma_professor`),
  ADD UNIQUE KEY `unique_turma_professor` (`id_turma`,`id_professor`),
  ADD KEY `fk_tp_turma` (`id_turma`),
  ADD KEY `fk_tp_professor` (`id_professor`);

--
-- Índices para tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`id_utilizador`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `unique_ref` (`tipo_perfil`,`id_ref`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos_turma`
--
ALTER TABLE `alunos_turma`
  MODIFY `id_aluno_turma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `atendimentos`
--
ALTER TABLE `atendimentos`
  MODIFY `id_atendimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `calendario_academico`
--
ALTER TABLE `calendario_academico`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `config_global`
--
ALTER TABLE `config_global`
  MODIFY `id_config` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `defesas_finais`
--
ALTER TABLE `defesas_finais`
  MODIFY `id_defesa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de tabela `documentos_emitidos`
--
ALTER TABLE `documentos_emitidos`
  MODIFY `id_documento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estudantes`
--
ALTER TABLE `estudantes`
  MODIFY `id_estudante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id_funcionario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `historico_status_estudante`
--
ALTER TABLE `historico_status_estudante`
  MODIFY `id_historico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `logs_operacoes`
--
ALTER TABLE `logs_operacoes`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `matriculas`
--
ALTER TABLE `matriculas`
  MODIFY `id_matricula` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `id_pagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pautas`
--
ALTER TABLE `pautas`
  MODIFY `id_pauta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `precos`
--
ALTER TABLE `precos`
  MODIFY `id_preco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `precos_padrao`
--
ALTER TABLE `precos_padrao`
  MODIFY `id_preco_padrao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `precos_por_curso`
--
ALTER TABLE `precos_por_curso`
  MODIFY `id_preco_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id_servico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id_turma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  MODIFY `id_turma_professor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  MODIFY `id_utilizador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `alunos_turma`
--
ALTER TABLE `alunos_turma`
  ADD CONSTRAINT `alunos_turma_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`) ON DELETE CASCADE,
  ADD CONSTRAINT `alunos_turma_ibfk_2` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `atendimentos`
--
ALTER TABLE `atendimentos`
  ADD CONSTRAINT `fk_atendimento_estudante` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`),
  ADD CONSTRAINT `fk_atendimento_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_funcionario`);

--
-- Limitadores para a tabela `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD CONSTRAINT `calendario_academico_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `calendario_academico_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `fk_curso_coordenador` FOREIGN KEY (`id_coordenador`) REFERENCES `funcionarios` (`id_funcionario`);

--
-- Limitadores para a tabela `defesas_finais`
--
ALTER TABLE `defesas_finais`
  ADD CONSTRAINT `defesas_finais_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD CONSTRAINT `disciplinas_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`);

--
-- Limitadores para a tabela `documentos_emitidos`
--
ALTER TABLE `documentos_emitidos`
  ADD CONSTRAINT `documentos_emitidos_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`) ON DELETE CASCADE,
  ADD CONSTRAINT `documentos_emitidos_ibfk_2` FOREIGN KEY (`id_secretario`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_documentos_servico` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`);

--
-- Limitadores para a tabela `estudantes`
--
ALTER TABLE `estudantes`
  ADD CONSTRAINT `estudantes_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_estudante_secretario` FOREIGN KEY (`matriculado_por`) REFERENCES `funcionarios` (`id_funcionario`);

--
-- Limitadores para a tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD CONSTRAINT `fk_funcionario_departamento` FOREIGN KEY (`id_departamento`) REFERENCES `departamentos` (`id_departamento`);

--
-- Limitadores para a tabela `historico_status_estudante`
--
ALTER TABLE `historico_status_estudante`
  ADD CONSTRAINT `historico_status_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`) ON DELETE CASCADE,
  ADD CONSTRAINT `historico_status_ibfk_2` FOREIGN KEY (`id_secretario`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `logs_operacoes`
--
ALTER TABLE `logs_operacoes`
  ADD CONSTRAINT `logs_operacoes_ibfk_1` FOREIGN KEY (`id_utilizador`) REFERENCES `utilizadores` (`id_utilizador`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `matriculas`
--
ALTER TABLE `matriculas`
  ADD CONSTRAINT `fk_matricula_estudante` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`),
  ADD CONSTRAINT `fk_matricula_secretario` FOREIGN KEY (`id_secretario`) REFERENCES `funcionarios` (`id_funcionario`);

--
-- Limitadores para a tabela `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`) ON DELETE CASCADE,
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE,
  ADD CONSTRAINT `notas_ibfk_3` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE SET NULL,
  ADD CONSTRAINT `notas_ibfk_4` FOREIGN KEY (`id_professor_lancamento`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE SET NULL,
  ADD CONSTRAINT `notas_ibfk_5` FOREIGN KEY (`id_pauta`) REFERENCES `pautas` (`id_pauta`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD CONSTRAINT `fk_pagamento_tesoureiro` FOREIGN KEY (`id_tesoureiro`) REFERENCES `funcionarios` (`id_funcionario`),
  ADD CONSTRAINT `fk_pagamentos_servico` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`),
  ADD CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `estudantes` (`id_estudante`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `pautas`
--
ALTER TABLE `pautas`
  ADD CONSTRAINT `pautas_ibfk_1` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE CASCADE,
  ADD CONSTRAINT `pautas_ibfk_2` FOREIGN KEY (`id_professor`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE CASCADE,
  ADD CONSTRAINT `pautas_ibfk_3` FOREIGN KEY (`id_coordenador_aprovacao`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `precos_padrao`
--
ALTER TABLE `precos_padrao`
  ADD CONSTRAINT `precos_padrao_ibfk_1` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`);

--
-- Limitadores para a tabela `precos_por_curso`
--
ALTER TABLE `precos_por_curso`
  ADD CONSTRAINT `precos_por_curso_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `precos_por_curso_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`);

--
-- Limitadores para a tabela `turmas`
--
ALTER TABLE `turmas`
  ADD CONSTRAINT `turmas_ibfk_1` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `turma_professores`
--
ALTER TABLE `turma_professores`
  ADD CONSTRAINT `turma_professores_ibfk_1` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE CASCADE,
  ADD CONSTRAINT `turma_professores_ibfk_2` FOREIGN KEY (`id_professor`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
