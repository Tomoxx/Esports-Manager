<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Tournament extends Model
{
    use HasFactory;
    protected $table = 'tournaments';

    public function teams()
    {
        return $this->hasManyThrough(Team::class, TournamentTeam::class);
    }

    public function tournament_teams(): HasMany
    {
        return $this->hasMany(TournamentTeam::class);
    }

    public function game_matches(): HasMany
    {
        return $this->hasMany(GameMatch::class);
    }
}
