-- Seed CLEP exam reference data
INSERT INTO clep_exams (id, name, category) VALUES
    (1,  'Biology',                 'Science'),
    (2,  'Chemistry',               'Science'),
    (3,  'College Algebra',         'Mathematics'),
    (4,  'Calculus',                'Mathematics'),
    (5,  'US History I',            'History & Social Sciences'),
    (6,  'US History II',           'History & Social Sciences'),
    (7,  'Western Civilization I',  'History & Social Sciences'),
    (8,  'Western Civilization II', 'History & Social Sciences'),
    (9,  'American Government',     'History & Social Sciences'),
    (10, 'Psychology',              'History & Social Sciences'),
    (11, 'Sociology',               'History & Social Sciences'),
    (12, 'Spanish Language',        'World Languages'),
    (13, 'French Language',         'World Languages'),
    (14, 'College Composition',     'Composition & Literature'),
    (15, 'English Literature',      'Composition & Literature')
ON CONFLICT (id) DO NOTHING;
