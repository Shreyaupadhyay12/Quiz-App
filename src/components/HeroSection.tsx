
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";

export const HeroSection = () => {
  const navigate = useNavigate();
  const { user } = useAuth();

  const handleStartQuiz = () => {
    if (!user) {
      navigate('/auth');
    } else {
      // Scroll to featured quizzes section
      const featuredSection = document.querySelector('[data-section="featured-quizzes"]');
      if (featuredSection) {
        featuredSection.scrollIntoView({ behavior: 'smooth' });
      }
    }
  };

  return (
    <section className="text-center py-20 px-6">
      <h1 className="text-6xl font-bold text-white mb-6">
        Test Your <span className="text-yellow-300">Knowledge</span>
      </h1>
      
      <p className="text-xl text-white/90 mb-12 max-w-2xl mx-auto">
        Challenge yourself with our interactive quizzes and discover how much
        you really know!
      </p>
      
      <div className="flex gap-6 justify-center flex-wrap">
        <Button 
          onClick={handleStartQuiz}
          size="lg"
          className="bg-white text-purple-700 hover:bg-gray-100 px-8 py-4 text-lg font-semibold rounded-full flex items-center gap-2"
        >
          🚀 Start Quiz Now
        </Button>
      </div>
    </section>
  );
};
