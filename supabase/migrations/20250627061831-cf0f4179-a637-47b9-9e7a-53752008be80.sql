
-- Add more questions for Mathematics
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is 2^5 (2 to the power of 5)?',
  '["16", "24", "32", "40"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is the formula for the area of a circle?',
  '["πr²", "2πr", "πd", "r²"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is 7 × 8?',
  '["54", "56", "58", "64"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is the value of x in the equation 2x + 6 = 18?',
  '["4", "5", "6", "7"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is 144 ÷ 12?',
  '["10", "11", "12", "13"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is the perimeter of a rectangle with length 8 and width 5?',
  '["18", "20", "24", "26"]'::jsonb,
  3
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is 0.25 as a fraction?',
  '["1/2", "1/3", "1/4", "1/5"]'::jsonb,
  2;

-- Add more questions for History
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Which empire was ruled by Julius Caesar?',
  '["Greek Empire", "Roman Empire", "Persian Empire", "Egyptian Empire"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'In which year did the Titanic sink?',
  '["1910", "1911", "1912", "1913"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Who was the first person to walk on the moon?',
  '["Buzz Aldrin", "Neil Armstrong", "John Glenn", "Alan Shepard"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Which war was fought between 1939-1945?',
  '["World War I", "World War II", "Korean War", "Vietnam War"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Which ancient civilization built the pyramids?',
  '["Romans", "Greeks", "Egyptians", "Babylonians"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Who wrote the Declaration of Independence?',
  '["George Washington", "Benjamin Franklin", "John Adams", "Thomas Jefferson"]'::jsonb,
  3
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Which year did the Berlin Wall fall?',
  '["1987", "1988", "1989", "1990"]'::jsonb,
  2;

-- Add more questions for Science
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What is the largest planet in our solar system?',
  '["Saturn", "Jupiter", "Neptune", "Uranus"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What gas do plants absorb from the atmosphere?',
  '["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What is the chemical formula for water?',
  '["H2O", "CO2", "NaCl", "CH4"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'Which organ in the human body produces insulin?',
  '["Liver", "Kidney", "Pancreas", "Heart"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What is the speed of light in vacuum?',
  '["300,000 km/s", "150,000 km/s", "450,000 km/s", "600,000 km/s"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'Which blood type is known as the universal donor?',
  '["A", "B", "AB", "O"]'::jsonb,
  3
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What is the hardest natural substance on Earth?',
  '["Gold", "Iron", "Diamond", "Platinum"]'::jsonb,
  2;

-- Add questions for Literature
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Who wrote "Romeo and Juliet"?',
  '["Charles Dickens", "William Shakespeare", "Jane Austen", "Mark Twain"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Which novel begins with "It was the best of times, it was the worst of times"?',
  '["Great Expectations", "Oliver Twist", "A Tale of Two Cities", "David Copperfield"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Who wrote "To Kill a Mockingbird"?',
  '["Harper Lee", "Toni Morrison", "Maya Angelou", "Zora Neale Hurston"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'In which Shakespeare play does the character Hamlet appear?',
  '["Macbeth", "Othello", "Hamlet", "King Lear"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Who wrote "1984"?',
  '["Aldous Huxley", "George Orwell", "Ray Bradbury", "Kurt Vonnegut"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Which poem begins with "Two roads diverged in a yellow wood"?',
  '["The Raven", "The Road Not Taken", "Stopping by Woods", "Fire and Ice"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Who wrote "Pride and Prejudice"?',
  '["Charlotte Brontë", "Emily Brontë", "Jane Austen", "Virginia Woolf"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'What is the first book in the Harry Potter series?',
  '["Chamber of Secrets", "Philosophers Stone", "Prisoner of Azkaban", "Goblet of Fire"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Who wrote "The Great Gatsby"?',
  '["Ernest Hemingway", "F. Scott Fitzgerald", "John Steinbeck", "William Faulkner"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Literature'),
  'Which novel features the character Atticus Finch?',
  '["To Kill a Mockingbird", "Of Mice and Men", "The Grapes of Wrath", "Brave New World"]'::jsonb,
  0;

-- Add questions for Geography
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'What is the capital of Australia?',
  '["Sydney", "Melbourne", "Canberra", "Brisbane"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'Which is the longest river in the world?',
  '["Amazon", "Nile", "Mississippi", "Yangtze"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'Which mountain range contains Mount Everest?',
  '["Andes", "Rocky Mountains", "Alps", "Himalayas"]'::jsonb,
  3
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'What is the smallest country in the world?',
  '["Monaco", "Vatican City", "San Marino", "Liechtenstein"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'Which desert is the largest in the world?',
  '["Gobi", "Sahara", "Arabian", "Kalahari"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'What is the capital of Canada?',
  '["Toronto", "Vancouver", "Montreal", "Ottawa"]'::jsonb,
  3
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'Which ocean is the largest?',
  '["Atlantic", "Indian", "Pacific", "Arctic"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'Which country has the most natural lakes?',
  '["Russia", "Canada", "Finland", "Sweden"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'What is the highest waterfall in the world?',
  '["Niagara Falls", "Victoria Falls", "Angel Falls", "Iguazu Falls"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Geography'),
  'Which European city is known as the "City of Canals"?',
  '["Amsterdam", "Vienna", "Venice", "Stockholm"]'::jsonb,
  2;

-- Add questions for Technology
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'What does "AI" stand for?',
  '["Automated Intelligence", "Artificial Intelligence", "Advanced Integration", "Algorithmic Interface"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'Who founded Microsoft?',
  '["Steve Jobs", "Bill Gates", "Mark Zuckerberg", "Larry Page"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'What does "HTTP" stand for?',
  '["HyperText Transfer Protocol", "High Tech Transfer Process", "Home Tool Transfer Protocol", "HyperText Technical Process"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'Which programming language is known for web development?',
  '["Python", "C++", "JavaScript", "Assembly"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'What does "CPU" stand for?',
  '["Central Processing Unit", "Computer Processing Unit", "Central Program Unit", "Computer Program Utility"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'Which company developed the iPhone?',
  '["Samsung", "Google", "Apple", "Microsoft"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'What does "URL" stand for?',
  '["Universal Resource Locator", "Uniform Resource Locator", "Universal Reference Link", "Uniform Reference Locator"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'Which social media platform was founded by Mark Zuckerberg?',
  '["Twitter", "Instagram", "Facebook", "LinkedIn"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'What does "RAM" stand for?',
  '["Random Access Memory", "Rapid Access Memory", "Read Access Memory", "Remote Access Memory"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Technology'),
  'Which company owns YouTube?',
  '["Facebook", "Microsoft", "Google", "Amazon"]'::jsonb,
  2;
