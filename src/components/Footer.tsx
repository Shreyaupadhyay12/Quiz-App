
export const Footer = () => {
  return (
    <footer className="bg-gray-900/90 backdrop-blur-sm mt-16">
      <div className="max-w-7xl mx-auto px-6 py-12">
        <div className="flex flex-col md:flex-row justify-between items-center">
          <div className="flex items-center gap-3 mb-6 md:mb-0">
            <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center">
              <span className="text-white font-bold text-xl">Q</span>
            </div>
            <div>
              <h3 className="text-white font-bold text-xl">Quiz App</h3>
              <p className="text-gray-400 text-sm">Learn. Challenge. Grow.</p>
            </div>
          </div>
          
          <div className="text-center md:text-right">
            <p className="text-gray-400 mb-2">© 2025 Quiz App. All rights reserved.</p>
            <p className="text-gray-500 text-sm">
              Created with ❤️ by <span className="text-purple-400">Shreya</span>
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
};
