import ClassKit
import UIKit

class GameViewController: UIViewController {
    let game: Game
    
    var playing = true {
        didSet {
            newGameButton.isEnabled = !playing
            endGameButton.isEnabled = playing
            newGameButton.setTitle(playing ? "" : "New Game", for: .normal)
            endGameButton.setTitle(playing ? "End Game" : "", for: .normal)
            updateGameButtonText()
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            updateGameButtonText()
        }
    }
    
    let endGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        
        return button
    }()
    
    let newGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New Game", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        
        return button
    }()
    
    let gameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        
        return button
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    init(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
        [titleLabel, scoreLabel, newGameButton, gameButton, endGameButton].forEach { stack.addArrangedSubview($0) }
        
        view.backgroundColor = game.backgroundColor
        titleLabel.text = game.title
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchDown)
        endGameButton.addTarget(self, action: #selector(endGame), for: .touchDown)
        gameButton.addTarget(self, action: #selector(hitGame), for: .touchDown)
        
        self.playing = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game.startActivity()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        game.endActivity()
    }
    
    @objc func newGame() {
        self.score = 0
        self.playing = true
    }
    
    @objc func endGame() {
        self.playing = false
        game.setScore(score)
        
        let alert = UIAlertController(title: "GOOD JOB!", message: "YOU DID IT", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hitGame() {
        self.score = score + 1
    }
    
    private func updateGameButtonText() {
        gameButton.setTitle(playing ? "TAP ME: \(game.symbolGenerator())" : "", for: .normal)
    }
}

