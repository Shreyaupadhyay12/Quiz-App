
import { Header } from "@/components/Header";
import { HeroSection } from "@/components/HeroSection";
import { FeaturedQuizzes } from "@/components/FeaturedQuizzes";
import { Footer } from "@/components/Footer";

const Index = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-purple-700 to-pink-600">
      <Header />
      <HeroSection />
      <div data-section="featured-quizzes">
        <FeaturedQuizzes />
      </div>
      <Footer />
    </div>
  );
};

export default Index;
