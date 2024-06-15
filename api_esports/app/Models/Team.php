<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Team extends Model
{
    use HasFactory;
    protected $table = 'teams';

    protected $appends = ['cantidad'];

    //relacion con players
    public function players(): HasMany
    {
        return $this->hasMany(Player::class);
    }

    public function tournaments(): HasMany
    {
        return $this->hasMany(TournamentTeam::class);
    }

    public function game_matches(): HasMany
    {
        return $this->hasMany(GameMatch::class);
    }

    //asignar valor a cantidad
    public function getCantidadAttribute()
    {
        return count($this->players);
    }
}
