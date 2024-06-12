<?php

namespace App\Http\Controllers;

use App\Models\GameMatch;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class GameMatchController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return GameMatch::all();
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
    public function store(Request $request)
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
    public function show(GameMatch $gameMatch)
    {
        return $gameMatch;
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
    public function update(Request $request, GameMatch $gameMatch)
    {
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
     * Remove the specified resource from storage.
     */
    public function destroy(GameMatch $gameMatch)
    {
        return $gameMatch->delete();
    }
}
