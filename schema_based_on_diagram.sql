CREATE TABLE patients(id INT PRIMARY KEY NOT NULL,name VARCHAR(50) NOT NULL,date_of_birth DATE NOT NULL);
CREATE TABLE medical_histories(id INT PRIMARY KEY NOT NULL,admitted_at TIMESTAMP NOT NULL,patient_id INT NOT NULL,status VARCHAR(50),FOREIGN KEY (patient_id) REFERENCES patients(id));
CREATE TABLE treatments(id INT PRIMARY KEY NOT NULL, type VARCHAR(50), name VARCHAR(100));
CREATE TABLE medical_history_treatments(medical_history_id INT NOT NULL,treatment_id INT NOT NULL,PRIMARY KEY (medical_history_id, treatment_id),FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),FOREIGN KEY (treatment_id) REFERENCES treatments(id));
CREATE TABLE invoices (id INT PRIMARY KEY NOT NULL,
                    generated_at TIMESTAMP NOT NULL,
                    payed_at TIMESTAMP NOT NULL,
                    medical_history_id INT NOT NULL,
                    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);
CREATE TABLE invoice_items (id INT PRIMARY KEY NOT NULL,
                        unit_price DECIMAL NOT NULL,
                        quantity INT NOT NULL,
                        total_price DECIMAL NOT NULL,
                        invoice_id INT NOT NULL,
                        treatment_id INT NOT NULL,
                        FOREIGN KEY (invoice_id) REFERENCES invoices(id),
                        FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);