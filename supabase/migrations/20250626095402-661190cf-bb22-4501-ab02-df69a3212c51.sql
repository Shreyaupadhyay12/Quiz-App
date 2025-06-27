
-- Create a table for quiz categories
CREATE TABLE public.quiz_categories (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  icon TEXT,
  color TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create a table for quiz questions
CREATE TABLE public.quiz_questions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  category_id UUID REFERENCES public.quiz_categories(id) ON DELETE CASCADE NOT NULL,
  question TEXT NOT NULL,
  options JSONB NOT NULL, -- Array of options
  correct_answer INTEGER NOT NULL, -- Index of correct answer (0-3)
  difficulty TEXT DEFAULT 'medium',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create a table for user quiz attempts
CREATE TABLE public.quiz_attempts (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  category_id UUID REFERENCES public.quiz_categories(id) ON DELETE CASCADE NOT NULL,
  score INTEGER NOT NULL DEFAULT 0,
  total_questions INTEGER NOT NULL,
  completed_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create a table for user profiles
CREATE TABLE public.profiles (
  id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT,
  full_name TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.quiz_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Create policies for quiz_categories (public read access)
CREATE POLICY "Anyone can view quiz categories" 
  ON public.quiz_categories 
  FOR SELECT 
  USING (true);

-- Create policies for quiz_questions (public read access)
CREATE POLICY "Anyone can view quiz questions" 
  ON public.quiz_questions 
  FOR SELECT 
  USING (true);

-- Create policies for quiz_attempts (users can only see their own attempts)
CREATE POLICY "Users can view their own quiz attempts" 
  ON public.quiz_attempts 
  FOR SELECT 
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own quiz attempts" 
  ON public.quiz_attempts 
  FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- Create policies for profiles
CREATE POLICY "Users can view their own profile" 
  ON public.profiles 
  FOR SELECT 
  USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" 
  ON public.profiles 
  FOR UPDATE 
  USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile" 
  ON public.profiles 
  FOR INSERT 
  WITH CHECK (auth.uid() = id);

-- Create a trigger to automatically create a profile when a user signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = ''
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (
    new.id,
    new.email,
    COALESCE(new.raw_user_meta_data->>'full_name', new.email)
  );
  RETURN new;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- Insert sample quiz categories
INSERT INTO public.quiz_categories (name, description, icon, color) VALUES
('Mathematics', 'Test your mathematical skills with algebra, geometry, and calculus problems.', 'M', 'from-purple-500 to-purple-600'),
('History', 'Journey through time with questions about world history and civilizations.', 'H', 'from-purple-500 to-pink-500'),
('Science', 'Explore physics, chemistry, and biology concepts in this comprehensive quiz.', 'S', 'from-purple-600 to-pink-600'),
('Literature', 'Test your knowledge of classic and modern literature from around the world.', 'L', 'from-purple-500 to-purple-600'),
('Geography', 'Explore countries, capitals, landmarks, and natural wonders of our planet.', 'G', 'from-purple-500 to-pink-500'),
('Technology', 'Stay updated with the latest in programming, AI, and digital innovations.', 'T', 'from-purple-600 to-pink-600');

-- Insert sample questions for Mathematics
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is the value of π (pi) rounded to two decimal places?',
  '["3.14", "3.16", "3.12", "3.18"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is the square root of 144?',
  '["10", "11", "12", "13"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Mathematics'),
  'What is 15% of 200?',
  '["25", "30", "35", "40"]'::jsonb,
  1;

-- Insert sample questions for History
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'In which year did World War II end?',
  '["1944", "1945", "1946", "1947"]'::jsonb,
  1
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Who was the first President of the United States?',
  '["Thomas Jefferson", "John Adams", "George Washington", "Benjamin Franklin"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'History'),
  'Which ancient wonder of the world was located in Alexandria?',
  '["Hanging Gardens", "Lighthouse of Alexandria", "Colossus of Rhodes", "Statue of Zeus"]'::jsonb,
  1;

-- Insert sample questions for Science
INSERT INTO public.quiz_questions (category_id, question, options, correct_answer) 
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What is the chemical symbol for gold?',
  '["Go", "Gd", "Au", "Ag"]'::jsonb,
  2
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'How many bones are there in an adult human body?',
  '["206", "208", "210", "212"]'::jsonb,
  0
UNION ALL
SELECT 
  (SELECT id FROM public.quiz_categories WHERE name = 'Science'),
  'What planet is known as the Red Planet?',
  '["Venus", "Jupiter", "Mars", "Saturn"]'::jsonb,
  2;
