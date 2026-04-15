-- Create tables in dependency order

CREATE TABLE IF NOT EXISTS users (
    id           SERIAL PRIMARY KEY,
    username     VARCHAR(255) UNIQUE NOT NULL,
    email        VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    school_id    INTEGER,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS clep_exams (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    category   VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS schools (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(255) NOT NULL,
    address          VARCHAR(255),
    city             VARCHAR(100),
    state            VARCHAR(2),
    zip              VARCHAR(10),
    latitude         DECIMAL(10, 8),
    longitude        DECIMAL(11, 8),
    website_url      VARCHAR(255),
    registrar_email  VARCHAR(255),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE users
    ADD CONSTRAINT fk_users_school
    FOREIGN KEY (school_id) REFERENCES schools(id)
    ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS sessions (
    id            SERIAL PRIMARY KEY,
    user_id       INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_token VARCHAR(255) UNIQUE NOT NULL,
    expires_at    TIMESTAMP NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_sessions_token   ON sessions(session_token);
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id);

CREATE TABLE IF NOT EXISTS school_policies (
    id               SERIAL PRIMARY KEY,
    school_id        INTEGER NOT NULL REFERENCES schools(id) ON DELETE CASCADE,
    exam_id          INTEGER NOT NULL REFERENCES clep_exams(id) ON DELETE CASCADE,
    min_score        INTEGER NOT NULL,
    course_code      VARCHAR(50),
    course_name      VARCHAR(255),
    credits          DECIMAL(4, 2),
    is_general_credit BOOLEAN DEFAULT FALSE,
    notes            TEXT,
    is_updated       BOOLEAN DEFAULT TRUE,
    updated_at       DATE,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(school_id, exam_id)
);

CREATE TABLE IF NOT EXISTS votes (
    id         SERIAL PRIMARY KEY,
    school_id  INTEGER NOT NULL REFERENCES schools(id) ON DELETE CASCADE,
    vote_type  VARCHAR(10) CHECK (vote_type IN ('upvote', 'downvote')),
    user_ip    VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_votes_school_id ON votes(school_id);
