DROP DATABASE jccoach;

CREATE DATABASE jccoach;

-- Création de la table Utilisateur
CREATE TABLE Utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    mail VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    role ENUM('Adherent', 'Coach') NOT NULL
);

-- Création de la table Rôle
CREATE TABLE Role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- Insertion des rôles disponibles
INSERT INTO Role (nom) VALUES ('Adherent'), ('Coach');

-- Création de la table Adhérent
CREATE TABLE Adherent (
    id INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    sexe CHAR(1),
    id_equipe INT,
    FOREIGN KEY (id) REFERENCES Utilisateur (id)
    -- Assurez-vous que la table Equipe existe si vous utilisez id_equipe
);

-- Création de la table Coach
CREATE TABLE Coach (
    id INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    FOREIGN KEY (id) REFERENCES Utilisateur (id)
);

-- Création de la table Programme
CREATE TABLE Programme (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);

-- Création de la table Exercice
CREATE TABLE Exercice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    serie INT NOT NULL,
    repetition INT NOT NULL,
    poids INT,
    temps_repos INT
);

-- Création de la table de jointure ProgrammeExercice
CREATE TABLE ProgrammeExercice (
    programme_id INT,
    exercice_id INT,
    ordre INT NOT NULL,
    FOREIGN KEY (programme_id) REFERENCES Programme (id),
    FOREIGN KEY (exercice_id) REFERENCES Exercice (id),
    PRIMARY KEY (programme_id, exercice_id)
);


DELIMITER $$

CREATE TRIGGER apres_insertion_utilisateur
AFTER INSERT ON Utilisateur
FOR EACH ROW
BEGIN
    IF NEW.role = 'Coach' THEN
        INSERT INTO Coach (id, nom, prenom) VALUES (NEW.id, NEW.nom, NEW.prenom);
    END IF;
END$$

DELIMITER ;

INSERT INTO Utilisateur (nom, prenom, mail, mot_de_passe, role)
VALUES ('Carpentier', 'Jean', 'Jean.Carpentier0@gmail.com', 'root', 'Coach');
-- Ajout des clés étrangères pour la table Adhérent si nécessaire
-- Assurez-vous que les tables Equipe et Produit existent avant de décommenter ces lignes
-- ALTER TABLE Adherent ADD FOREIGN KEY (id_equipe) REFERENCES Equipe (id);
-- ALTER TABLE Adherent ADD FOREIGN KEY (id_produit) REFERENCES Produit (id);
