<?php

use App\Http\Controllers\TeamController;
use App\Http\Controllers\PlayerController;
use App\Http\Controllers\GameMatchController;
use App\Http\Controllers\TournamentController;
use App\Http\Controllers\TournamentTeamController;
use App\Http\Controllers\VenueController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::resource('/teams', TeamController::class);
Route::get('/teams/{id}/players', [TeamController::class, 'getPlayers']);
Route::resource('/players', PlayerController::class);
Route::resource('/matches', GameMatchController::class);
Route::get('matches/{id}', [GameMatchController::class, 'show']);
Route::resource('/tournaments', TournamentController::class);
Route::get('/tournaments/{id}/teams', [TournamentTeamController::class, 'getTeams']);
Route::get('/tournaments/{id}/matches', [GameMatchController::class, 'getMatches']);
Route::resource('/tournament_teams', TournamentTeamController::class);
Route::resource('/venues', VenueController::class);
