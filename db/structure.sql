CREATE TABLE "lols" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "vanne_id" integer, "membre_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "membres" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "pseudo" varchar(255), "hashed_passwd" varchar(255), "salt" varchar(255), "email" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "vannes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contenu" text, "membre_id" integer, "date" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120217202557');

INSERT INTO schema_migrations (version) VALUES ('20120218130120');

INSERT INTO schema_migrations (version) VALUES ('20120219152702');