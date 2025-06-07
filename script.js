const questionEl = document.getElementById('question');
const optionsEl = document.getElementById('options');
const nextBtn = document.getElementById('next');
const resultEl = document.getElementById('result');

let questions = [];
let currentQuestionIndex = 0;
let score = 0;

// Fetch questions from Open Trivia Database API
async function fetchQuestions() {
  try {
    const res = await fetch('https://opentdb.com/api.php?amount=5&type=multiple');
    const data = await res.json();
    questions = data.results.map(q => {
      const options = [...q.incorrect_answers];
      const correctIndex = Math.floor(Math.random() * 4);
      options.splice(correctIndex, 0, q.correct_answer);
      return {
        question: decodeHTML(q.question),
        options: options.map(opt => decodeHTML(opt)),
        correctAnswer: decodeHTML(q.correct_answer)
      };
    });
    displayQuestion();
  } catch (error) {
    questionEl.textContent = 'Failed to load questions.';
    console.error(error);
  }
}

// Decode HTML entities
function decodeHTML(html) {
  const txt = document.createElement('textarea');
  txt.innerHTML = html;
  return txt.value;
}

// Display current question
function displayQuestion() {
  const current = questions[currentQuestionIndex];
  questionEl.textContent = `Q${currentQuestionIndex + 1}: ${current.question}`;
  optionsEl.innerHTML = '';
  current.options.forEach((option, index) => {
    const label = document.createElement('label');
    label.classList.add('option');
    const input = document.createElement('input');
    input.type = 'radio';
    input.name = 'option';
    input.value = option;
    input.addEventListener('change', () => {
      nextBtn.disabled = false;
    });
    label.appendChild(input);
    label.appendChild(document.createTextNode(option));
    optionsEl.appendChild(label);
  });
  nextBtn.disabled = true;
}

// Handle next button click
nextBtn.addEventListener('click', () => {
  const selectedOption = document.querySelector('input[name="option"]:checked');
  if (selectedOption && selectedOption.value === questions[currentQuestionIndex].correctAnswer) {
    score++;
  }
  currentQuestionIndex++;
  if (currentQuestionIndex < questions.length) {
    displayQuestion();
  } else {
    showResult();
  }
});

// Display final result
function showResult() {
  document.getElementById('quiz').classList.add('hidden');
  resultEl.classList.remove('hidden');
  resultEl.textContent = `You scored ${score} out of ${questions.length}!`;
}

// Initialize quiz
fetchQuestions();
