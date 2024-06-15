<?php

namespace App\Http\Controllers;

use App\Models\TournamentTeam;
use App\Http\Controllers\Controller;
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
            ->with('team')
            ->get()
            ->map(function ($tournamentTeam) {
                return [
                    'id' => $tournamentTeam->team->id,
                    'tournament_team_id' => $tournamentTeam->id,
                    'name' => $tournamentTeam->team->name,
                    'game' => $tournamentTeam->team->game,
                    'region' => $tournamentTeam->team->region,
                    'placement' => $tournamentTeam->placement,
                ];
            });

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
        $tournamentTeam = new TournamentTeam();
        $tournamentTeam->tournament_id = $request->tournament_id;
        $tournamentTeam->team_id = $request->team_id;
        $tournamentTeam->placement = $request->placement;
        $tournamentTeam->save();
        return $tournamentTeam;
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
        $tournamentTeam->placement = $request->placement;
        $tournamentTeam->save();
        return $tournamentTeam;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(TournamentTeam $tournamentTeam)
    {
        return $tournamentTeam->delete();
    }
}
