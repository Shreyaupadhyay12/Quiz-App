
import React, { useState, useEffect } from 'react';
import { QuizCard } from "./QuizCard";
import { supabase } from '@/integrations/supabase/client';

interface Quiz {
  id: string;
  letter: string;
  title: string;
  description: string;
  duration: string;
  questions: string;
  color: string;
}

export const FeaturedQuizzes = () => {
  const [quizzes, setQuizzes] = useState<Quiz[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchQuizzes();
  }, []);

  const fetchQuizzes = async () => {
    try {
      const { data, error } = await supabase
        .from('quiz_categories')
        .select(`
          id,
          name,
          description,
          icon,
          color,
          quiz_questions (count)
        `);

      if (error) throw error;

      const formattedQuizzes: Quiz[] = data.map((category: any) => ({
        id: category.id,
        letter: category.icon || category.name.charAt(0),
        title: category.name,
        description: category.description || '',
        duration: "15 min", // Default duration
        questions: `${category.quiz_questions?.length || 0} questions`,
        color: category.color || "from-purple-500 to-purple-600"
      }));

      setQuizzes(formattedQuizzes);
    } catch (error) {
      console.error('Error fetching quizzes:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <section className="py-16 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-4xl font-bold text-white mb-4">Featured Quizzes</h2>
            <p className="text-lg text-white/80 max-w-2xl mx-auto">
              Loading available quizzes...
            </p>
          </div>
        </div>
      </section>
    );
  }

  return (
    <section className="py-16 px-6">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-12">
          <h2 className="text-4xl font-bold text-white mb-4">Featured Quizzes</h2>
          <p className="text-lg text-white/80 max-w-2xl mx-auto">
            Discover our most popular quizzes and challenge yourself with questions across
            various topics.
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {quizzes.map((quiz) => (
            <QuizCard key={quiz.id} quiz={quiz} />
          ))}
        </div>
      </div>
    </section>
  );
};
