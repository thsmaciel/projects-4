create database universidade;
use universidade;

-- tabela curso
create table curso (
	curso_id int auto_increment primary key	unique,
    nome_curso varchar(100) not null,
    descricao varchar (250) not null
);

-- tabela alunos
create table aluno (
	aluno_id int auto_increment primary key unique,
    nome varchar(90) not null,
    sobrenome varchar (90) not null,
    email varchar (100) not null,
    id_curso int,
    foreign key (id_curso) references curso (curso_id)
);

-- tabela professores
create table professores(
	professores_id int auto_increment primary key unique,
    nome varchar (90)  not null,
    sobrenome varchar (90) not null,
    email varchar(100) not null,
    idd_curso int,
    foreign key (idd_curso) references curso (curso_id)
);

-- inserção de valores em cada tabela
insert into aluno (nome, sobrenome, email, id_curso) values ('Matheus', 'Maciel', '', 3),
('Nicolas','Maciel','', 3),
('Luciane','Maciel','', 2);

insert into curso (nome_curso, descricao) values ('Matemática', 'Aula de cálculos'),
('Português', 'Estudo da linguagem'),
('Geografia', 'Geografia');

insert into professores (nome, sobrenome, email, IDD_curso) values ('José', 'Valter', '', 1),
('Marileide', 'Amorim', '', 2),
('Caio', 'Felipe', '', 3);


-- automatização da inserção e seleção de cursos
DELIMITER $$

create procedure inserir_curso(
	in nome_curso varchar(100),
    in descricao varchar(100)
)
begin
	insert into curso (nome_curso, descricao) values (nome_curso, descricao);
end$$

create procedure selecionar_curso()
begin
	select * from curso;
	end$$
    
DELIMITER ;


-- automatização de emails gerados por nome e sobrenome
DELIMITER $$



create procedure gerar_email(
	in alunoID int
)
begin
	declare nome_aluno varchar(90);
    declare sobrenome_aluno varchar(90);
    declare aluno_email varchar(100);
    
    select nome, sobrenome into nome_aluno, sobrenome_aluno from aluno where aluno_id = alunoID;
    
    set aluno_email = concat(nome_aluno, '.', sobrenome_aluno, '@dominio.com');
    
    update aluno set email = aluno_email where aluno_id = alunoID;
end$$

DELIMITER ;


-- procedure para vizualização dos alunos e seus dados já com emails gerados
DELIMITER $$


create procedure aluno_fim ()
begin
	select * from aluno;
end $$

DELIMITER ;

call inserir_curso('Inglês', 'Estudo da lingua estrangeira');
call selecionar_curso();

call gerar_email(3); -- número entre parênteses representa o ID do aluno ao qual será gerado o email (alterar entre 1 e 3)
call aluno_fim();






