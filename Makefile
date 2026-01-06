postgres:
	docker run --name bank_simulation -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine

createdb:
	docker exec -it bank_simulation createdb --username=root --owner=root bank_db

dropdb:
	docker exec -it bank_simulation dropdb bank_db

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/bank_db?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/bank_db?sslmode=disable" -verbose down

.PHONY: postgres createdb dropdb migrateup migratedown