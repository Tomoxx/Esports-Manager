<?php

namespace App\Http\Controllers;

use App\Models\Team;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class TeamController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // return Team::all();
        return Team::orderBy('game')->get()->makeHidden('players');
    }

    public function getPlayers($teamId)
    {
        $team = Team::find($teamId);

        if (!$team) {
            return response()->json(['error' => 'Team not found'], 404);
        }

        $players = $team->players()->get();
        return response()->json($players);
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
        $team = new Team();
        $team->name = $request->name;
        $team->game = $request->game;
        $team->region = $request->region;
        $team->save();
        return $team;
    }

    /**
     * Display the specified resource.
     */
    public function show(Team $team)
    {
        // Hide the 'players' relationship
        $team->makeHidden('players');
        return $team;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Team $team)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Team $team)
    {
        $team->name = $request->name;
        $team->game = $request->game;
        $team->region = $request->region;
        $team->save();
        return $team;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Team $team)
    {
        return $team->delete();
    }
}
