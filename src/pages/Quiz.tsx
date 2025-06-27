import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { useToast } from '@/hooks/use-toast';
import { ArrowLeft, Clock, CheckCircle } from 'lucide-react';

interface Question {
  id: string;
  question: string;
  options: string[];
  correct_answer: number;
}

interface Category {
  id: string;
  name: string;
  description: string;
  color: string;
}

const Quiz = () => {
  const { categoryId } = useParams();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { toast } = useToast();

  const [category, setCategory] = useState<Category | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [answers, setAnswers] = useState<number[]>([]);
  const [quizCompleted, setQuizCompleted] = useState(false);
  const [score, setScore] = useState(0);
  const [loading, setLoading] = useState(true);
  const [timeLeft, setTimeLeft] = useState(900); // 15 minutes

  useEffect(() => {
    if (!user) {
      navigate('/auth');
      return;
    }

    fetchQuizData();
  }, [categoryId, user, navigate]);

  useEffect(() => {
    if (timeLeft > 0 && !quizCompleted) {
      const timer = setTimeout(() => setTimeLeft(timeLeft - 1), 1000);
      return () => clearTimeout(timer);
    } else if (timeLeft === 0 && !quizCompleted) {
      handleQuizSubmit();
    }
  }, [timeLeft, quizCompleted]);

  const fetchQuizData = async () => {
    try {
      // Fetch category
      const { data: categoryData, error: categoryError } = await supabase
        .from('quiz_categories')
        .select('*')
        .eq('id', categoryId)
        .single();

      if (categoryError) throw categoryError;
      setCategory(categoryData);

      // Fetch questions
      const { data: questionsData, error: questionsError } = await supabase
        .from('quiz_questions')
        .select('*')
        .eq('category_id', categoryId)
        .limit(10);

      if (questionsError) throw questionsError;
      
      // Transform the data to match our Question interface
      const transformedQuestions: Question[] = questionsData.map(q => ({
        id: q.id,
        question: q.question,
        options: Array.isArray(q.options) ? q.options as string[] : JSON.parse(q.options as string),
        correct_answer: q.correct_answer
      }));
      
      setQuestions(transformedQuestions);
      setLoading(false);
    } catch (error) {
      console.error('Error fetching quiz data:', error);
      toast({
        title: "Error",
        description: "Failed to load quiz data",
        variant: "destructive"
      });
      navigate('/');
    }
  };

  const handleAnswerSelect = (answerIndex: number) => {
    setSelectedAnswer(answerIndex);
  };

  const handleNextQuestion = () => {
    if (selectedAnswer === null) {
      toast({
        title: "Please select an answer",
        description: "You must select an answer before proceeding",
        variant: "destructive"
      });
      return;
    }

    const newAnswers = [...answers, selectedAnswer];
    setAnswers(newAnswers);
    setSelectedAnswer(null);

    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    } else {
      handleQuizSubmit(newAnswers);
    }
  };

  const handleQuizSubmit = async (finalAnswers: number[] = answers) => {
    const calculatedScore = finalAnswers.reduce((acc, answer, index) => {
      return acc + (answer === questions[index]?.correct_answer ? 1 : 0);
    }, 0);

    setScore(calculatedScore);
    setQuizCompleted(true);

    // Save quiz attempt to database
    try {
      const { error } = await supabase
        .from('quiz_attempts')
        .insert({
          user_id: user!.id,
          category_id: categoryId!,
          score: calculatedScore,
          total_questions: questions.length
        });

      if (error) throw error;
    } catch (error) {
      console.error('Error saving quiz attempt:', error);
    }
  };

  const formatTime = (seconds: number) => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-600 via-purple-700 to-pink-600 flex items-center justify-center">
        <div className="text-white text-xl">Loading quiz...</div>
      </div>
    );
  }

  if (quizCompleted) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-600 via-purple-700 to-pink-600 flex items-center justify-center p-6">
        <Card className="bg-white/95 backdrop-blur-sm p-8 rounded-2xl shadow-xl max-w-md w-full text-center">
          <CheckCircle className="w-16 h-16 text-green-500 mx-auto mb-4" />
          <h2 className="text-3xl font-bold text-gray-800 mb-4">Quiz Complete!</h2>
          <p className="text-xl text-gray-600 mb-6">
            You scored {score} out of {questions.length}
          </p>
          <p className="text-lg text-gray-600 mb-8">
            That's {Math.round((score / questions.length) * 100)}%!
          </p>
          <div className="space-y-4">
            <Button
              onClick={() => navigate('/')}
              className="w-full bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white py-3 rounded-xl font-semibold"
            >
              Back to Home
            </Button>
            <Button
              onClick={() => window.location.reload()}
              variant="outline"
              className="w-full border-2 border-purple-500 text-purple-600 hover:bg-purple-50 py-3 rounded-xl font-semibold"
            >
              Take Quiz Again
            </Button>
          </div>
        </Card>
      </div>
    );
  }

  const currentQuestion = questions[currentQuestionIndex];

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-purple-700 to-pink-600 p-6">
      <div className="max-w-4xl mx-auto">
        <div className="flex items-center justify-between mb-8">
          <Button
            variant="ghost"
            onClick={() => navigate('/')}
            className="text-white hover:bg-white/20"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            Back to Home
          </Button>
          
          <div className="flex items-center gap-4 text-white">
            <div className="flex items-center gap-2">
              <Clock className="w-5 h-5" />
              <span className="font-semibold">{formatTime(timeLeft)}</span>
            </div>
            <div className="bg-white/20 px-4 py-2 rounded-full">
              {currentQuestionIndex + 1} / {questions.length}
            </div>
          </div>
        </div>

        <Card className="bg-white/95 backdrop-blur-sm p-8 rounded-2xl shadow-xl">
          <div className="mb-6">
            <h1 className="text-2xl font-bold text-gray-800 mb-2">{category?.name} Quiz</h1>
            <div className="w-full bg-gray-200 rounded-full h-2">
              <div
                className="bg-gradient-to-r from-purple-500 to-pink-500 h-2 rounded-full transition-all duration-300"
                style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
              />
            </div>
          </div>

          <div className="mb-8">
            <h2 className="text-xl font-semibold text-gray-800 mb-6">
              {currentQuestion?.question}
            </h2>

            <div className="space-y-4">
              {currentQuestion?.options.map((option, index) => (
                <button
                  key={index}
                  onClick={() => handleAnswerSelect(index)}
                  className={`w-full p-4 text-left rounded-xl border-2 transition-all duration-200 ${
                    selectedAnswer === index
                      ? 'border-purple-500 bg-purple-50 text-purple-700'
                      : 'border-gray-200 hover:border-purple-300 hover:bg-purple-50'
                  }`}
                >
                  <span className="font-medium">{String.fromCharCode(65 + index)}.</span> {option}
                </button>
              ))}
            </div>
          </div>

          <div className="flex justify-end">
            <Button
              onClick={handleNextQuestion}
              className="bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white px-8 py-3 rounded-xl font-semibold"
            >
              {currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz'}
            </Button>
          </div>
        </Card>
      </div>
    </div>
  );
};

export default Quiz;
