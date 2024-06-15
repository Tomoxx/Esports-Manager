<?php

namespace App\Http\Controllers;

use App\Models\Tournament;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\TournamentRequest;

class TournamentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Tournament::orderBy('game')->get();
    }

    public function getTeamsByTournamentId($tournamentId)
    {
        $tournament = Tournament::find($tournamentId);

        if (!$tournament) {
            return response()->json(['error' => 'Tournament not found'], 404);
        }

        $teams = $tournament->teams()->get();
        return response()->json($teams);
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
    public function store(TournamentRequest $request)
    {
        $tournament = new Tournament();
        $tournament->name = $request->name;
        $tournament->game = $request->game;
        $tournament->type = $request->type;
        $tournament->start_date = $request->start_date;
        $tournament->end_date = $request->end_date;
        $tournament->save();
        return $tournament;
    }

    /**
     * Display the specified resource.
     */
    public function show(Tournament $tournament)
    {
        return $tournament;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Tournament $tournament)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(TournamentRequest $request, Tournament $tournament)
    {
        $request =

            $tournament->name = $request->name;
        $tournament->game = $request->game;
        $tournament->type = $request->type;
        $tournament->start_date = $request->start_date;
        $tournament->end_date = $request->end_date;
        $tournament->save();
        return $tournament;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Tournament $tournament)
    {
        return $tournament->delete();
    }
}
