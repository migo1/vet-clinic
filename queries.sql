/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals;
SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO SAVEPOINT sp1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) AS escapes_most FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name AS melony_animals FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name AS pokemon_animals FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name , animals.name AS animal_name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;
SELECT s.name AS species_name, COUNT(*) AS animal_count FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owners_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name, COUNT(animals.id) AS number_of_animals FROM owners LEFT JOIN animals ON owners.id = animals.owners_idGROUP BY owners.full_name ORDER BY number_of_animals DESCLIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, MAX(vt.date_of_visit) AS last_visit_date
FROM visits vt JOIN animals a ON vt.animal_id = a.id
JOIN vets v ON vt.vet_id = v.id WHERE v.name = 'William Tatcher'
GROUP BY a.name, v.name ORDER BY last_visit_date DESC LIMIT 1;

SELECT COUNT(DISTINCT vt.animal_id) AS num_different_animals
FROM visits vt JOIN vets v ON vt.vet_id = v.id WHERE v.name = 'Stephanie Mendez';

SELECT v.name AS vet_name, s.name AS specialty_name FROM vets v 
LEFT JOIN specializations sp ON v.id = sp.vet_id LEFT JOIN species s ON sp.species_id = s.id ORDER BY v.name;

SELECT a.name AS animal_name, vt.date_of_visit FROM visits vt JOIN animals a ON vt.animal_id = a.id
JOIN vets v ON vt.vet_id = v.id WHERE v.name = 'Stephanie Mendez'
AND vt.date_of_visit >= '2020-04-01' AND vt.date_of_visit <= '2020-08-30'
ORDER BY vt.date_of_visit;

SELECT a.name AS animal_name, COUNT(vt.animal_id) AS num_visits
FROM visits vt JOIN animals a ON vt.animal_id = a.id
GROUP BY a.name ORDER BY num_visits DESC
LIMIT 1;

SELECT a.name AS animal_name, vt.date_of_visit
FROM visits vt JOIN animals a ON vt.animal_id = a.id
JOIN vets v ON vt.vet_id = v.id WHERE v.name = 'Maisy Smith'
ORDER BY vt.date_of_visit
LIMIT 1;

SELECT a.name AS animal_name, a.date_of_birth AS DOB, v.name AS vet_name, v.age AS vet_age, vt.date_of_visit
FROM visits vt JOIN animals a ON vt.animal_id = a.id
JOIN vets v ON vt.vet_id = v.id ORDER BY vt.date_of_visit DESC
LIMIT 1;

vet_clinic=# SELECT COUNT(*) FROM visits v JOIN animals a ON v.animal_id = a.id 
JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations sp ON vt.id = sp.vet_id 
AND a.species_id = sp.species_id WHERE sp.vet_id IS NULL;

SELECT sp.name AS specialization, COUNT(sp.name) FROM animals AS a 
JOIN species AS sp ON a.species_id = sp.id JOIN visits AS vt ON a.id = vt.animal_id 
JOIN vets AS v ON v.id = vt.vet_id WHERE v.name = 'Maisy Smith' 
GROUP BY sp.name ORDER BY COUNT(sp.name) DESC LIMIT 1;