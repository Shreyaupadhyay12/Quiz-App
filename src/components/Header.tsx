
import { Home, User, LogOut } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useAuth } from "@/contexts/AuthContext";
import { useNavigate } from "react-router-dom";

export const Header = () => {
  const { user, signOut } = useAuth();
  const navigate = useNavigate();

  const handleSignOut = async () => {
    await signOut();
    navigate('/');
  };

  return (
    <header className="flex items-center justify-between p-6 bg-white/10 backdrop-blur-sm">
      <div className="flex items-center gap-3">
        <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center">
          <span className="text-white font-bold text-xl">Q</span>
        </div>
        <span className="text-white font-semibold text-xl">QuizApp</span>
      </div>
      
      <div className="flex items-center gap-4">
        <Button 
          variant="ghost" 
          onClick={() => navigate('/')}
          className="text-white hover:bg-white/20 flex items-center gap-2"
        >
          <Home size={20} />
          Home
        </Button>
        
        {user ? (
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2 text-white">
              <User size={20} />
              <span className="text-sm">{user.email}</span>
            </div>
            <Button 
              onClick={handleSignOut}
              variant="ghost"
              className="text-white hover:bg-white/20 flex items-center gap-2"
            >
              <LogOut size={20} />
              Sign Out
            </Button>
          </div>
        ) : (
          <Button 
            onClick={() => navigate('/auth')}
            className="bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white px-6 py-2 rounded-full font-medium"
          >
            Sign In
          </Button>
        )}
      </div>
    </header>
  );
};
