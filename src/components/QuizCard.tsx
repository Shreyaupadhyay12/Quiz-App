
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { useToast } from "@/hooks/use-toast";

interface Quiz {
  id: string;
  letter: string;
  title: string;
  description: string;
  duration: string;
  questions: string;
  color: string;
}

interface QuizCardProps {
  quiz: Quiz;
}

export const QuizCard = ({ quiz }: QuizCardProps) => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const { toast } = useToast();

  const handleStartQuiz = () => {
    if (!user) {
      toast({
        title: "Sign in required",
        description: "Please sign in to take quizzes and track your progress",
        variant: "destructive"
      });
      navigate('/auth');
      return;
    }

    navigate(`/quiz/${quiz.id}`);
  };

  return (
    <Card className="bg-white/95 backdrop-blur-sm p-6 rounded-2xl shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105">
      <div className="text-center mb-6">
        <div className={`w-16 h-16 bg-gradient-to-br ${quiz.color} rounded-2xl flex items-center justify-center mx-auto mb-4`}>
          <span className="text-white font-bold text-2xl">{quiz.letter}</span>
        </div>
        <h3 className="text-2xl font-bold text-gray-800 mb-2">{quiz.title}</h3>
        <p className="text-gray-600 text-sm leading-relaxed">{quiz.description}</p>
      </div>
      
      <Button 
        onClick={handleStartQuiz}
        className={`w-full bg-gradient-to-r ${quiz.color} hover:opacity-90 text-white py-3 rounded-xl font-semibold transition-all duration-200`}
      >
        🎯 Start Quiz
      </Button>
    </Card>
  );
};
