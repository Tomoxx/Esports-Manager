<?php

namespace App\Http\Controllers;

use App\Models\TournamentTeam;
use App\Http\Controllers\Controller;
use App\Models\Tournament;
use Illuminate\Http\Request;

class TournamentTeamController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return TournamentTeam::all();
    }

    public function getTeams($tournament_id)
    {
        $teams = TournamentTeam::where('tournament_id', $tournament_id)
            ->with('team') // Assuming you have a relationship defined in TournamentTeam model to get team details
            ->get();
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
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(TournamentTeam $tournamentTeam)
    {
        return $tournamentTeam;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(TournamentTeam $tournamentTeam)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, TournamentTeam $tournamentTeam)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(TournamentTeam $tournamentTeam)
    {
        //
    }
}
