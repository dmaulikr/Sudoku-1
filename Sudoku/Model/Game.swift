//
//  Game.swift
//  Sudoku
//
//  Created by Sashank Gogula on 12/24/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import EDStorage

class Game: NSObject, NSCoding {
	
	var puzzle: [Square]
	var solution: [Square]
	var playerSquares: [Square]
	
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(NSArray(array: puzzle.map{ $0.hashValue }), forKey: PuzzlePropertyKeys.puzzleKey)
		aCoder.encodeObject(NSArray(array: solution.map{ $0.hashValue }), forKey: PuzzlePropertyKeys.solutionKey)
		aCoder.encodeObject(NSArray(array: playerSquares.map{ $0.hashValue }), forKey: PuzzlePropertyKeys.playerSquaresKey)
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		self.puzzle = ((aDecoder.decodeObjectForKey(PuzzlePropertyKeys.puzzleKey) as! NSArray) as! [Int]).map(Square.hashToSquare)
		self.solution = ((aDecoder.decodeObjectForKey(PuzzlePropertyKeys.solutionKey) as! NSArray) as! [Int]).map(Square.hashToSquare)
		self.playerSquares = ((aDecoder.decodeObjectForKey(PuzzlePropertyKeys.playerSquaresKey) as! NSArray) as! [Int]).map(Square.hashToSquare)
	}
	
	func save()
	{
		let data = NSKeyedArchiver.archivedDataWithRootObject(self)
		data.persistToCacheWithExtension("puzzle", success: { url, size in NSUserDefaults.standardUserDefaults().setURL(url, forKey: "puzzle")}, failure: {error in print(error)})
	}

	init(puzzle: [Square], solution: [Square], playerSquares: [Square])
	{
		self.puzzle = puzzle
		self.solution = solution
		self.playerSquares = playerSquares
	}
	
	struct PuzzlePropertyKeys {
		static let puzzleKey = "puzzle"
		static let solutionKey = "solution"
		static let playerSquaresKey = "player"
	}
}