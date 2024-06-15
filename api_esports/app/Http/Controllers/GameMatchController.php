<?php

namespace App\Http\Controllers;

use App\Models\GameMatch;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\GameMatchRequest;

class GameMatchController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return GameMatch::all();
    }

    public function getMatches($tournament_id)
    {
        $matches = GameMatch::where('tournament_id', $tournament_id)
            ->with(['homeTeam', 'awayTeam', 'venue']) // Assuming relationships are defined in Match model
            ->get();
        return response()->json($matches);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(GameMatchRequest $request)
    {
        $gameMatch = new GameMatch();
        $gameMatch->tournament_id = $request->tournament_id;
        $gameMatch->home_team_id = $request->home_team_id;
        $gameMatch->away_team_id = $request->away_team_id;
        $gameMatch->venue_id = $request->venue_id;
        $gameMatch->match_date = $request->match_date;
        $gameMatch->home_team_score = $request->home_team_score;
        $gameMatch->away_team_score = $request->away_team_score;
        $gameMatch->save();
        return $gameMatch;
    }

    /**
     * Display the specified resource.
     */
    public function show($gameMatch_id)
    {
        $gameMatch = GameMatch::where('id', $gameMatch_id)
            ->with(['homeTeam', 'awayTeam', 'venue']) // Assuming relationships are defined in Match model
            ->get();
        return response()->json($gameMatch);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(GameMatch $gameMatch)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(GameMatchRequest $request, $id)
    {
        // Find the match by ID
        $gameMatch = GameMatch::find($id);

        // Check if the match exists
        if (!$gameMatch) {
            return response()->json(['message' => 'Match not found'], 404);
        }

        // Update the match scores and date
        $gameMatch->home_team_score = $request['home_team_score'];
        $gameMatch->away_team_score = $request['away_team_score'];
        $gameMatch->match_date = $request['match_date'];
        $gameMatch->save();

        return response()->json($gameMatch, 200);
    }

    public function destroy($gameMatch_id)
    {
        $gameMatch = GameMatch::find($gameMatch_id);
        if (!$gameMatch) {
            return response()->json(['message' => 'Match not found'], 404);
        }
        return $gameMatch->delete();
    }
    /**
     * Remove the specified resource from storage.
     */
    // public function destroy(GameMatch $gameMatch)
    // {
    //     return $gameMatch->delete();
    // }
}
